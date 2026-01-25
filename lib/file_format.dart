import 'dart:io';
import 'dart:typed_data';
import 'dart:convert';

import 'package:crypto/crypto.dart';

class FileFormatException implements Exception {
  final String message;
  FileFormatException(this.message);
  @override
  String toString() => 'FileFormatException: $message';
}

class CampaignFileResult {
  CampaignFileResult({required this.payload, required this.flags});

  final Uint8List payload;
  final int flags;
}

class CampaignFileFormat {
  static final Uint8List magic = utf8.encode('CMPTRK'); // 6 bytes
  static const int headerVersion = 1;

  // header structure
  static const int magicLen = 6; // starting magic bytes
  static const int versionLen = 1; // header version
  static const int flagsLen = 4; // flags - currently unused
  static const int payloadSizeLen = 4; // content length
  static const int headerSize =
      magicLen + versionLen + flagsLen + payloadSizeLen;

  // footer structure
  static const int hashLen = 32;

  static Future writeFile({
    required File file,
    required Uint8List protobufPayload,
    int flags = 0,
  }) async {
    if (protobufPayload.length > 0xFFFFFFFF) {
      throw ArgumentError('Payload too large');
    }

    final sink = file.openWrite();

    sink.add(magic);
    sink.add([headerVersion]);
    sink.add(_u32ToBytes(flags));

    sink.add(_u32ToBytes(protobufPayload.length));
    sink.add(protobufPayload);

    final digest = sha256.convert(protobufPayload).bytes;
    sink.add(digest.sublist(0, hashLen));

    await sink.close();
  }

  static Future<CampaignFileResult> readFile(File file) async {
    if (!await file.exists())
      throw FileSystemException('File not found', file.path);

    final bytes = await file.readAsBytes();
    if (bytes.length < headerSize) {
      throw FileFormatException('File too small to contain header');
    }

    final data = bytes.buffer.asUint8List();
    var offset = 0;

    // read header - starting magic bytes
    final fileMagic = data.sublist(offset, offset += magicLen);
    if (!_listEquals(fileMagic, magic)) {
      throw FileFormatException('Magic bytes do not match');
    }

    // read header - version
    final version = data[offset];
    if (version != headerVersion) {
      throw FileFormatException('Unsupported version: $version');
    }
    offset += versionLen;

    // read header - flags
    final flags = _bytesToU32(data.sublist(offset, offset += flagsLen));

    // read header - payload size
    final payloadSize = _bytesToU32(
      data.sublist(offset, offset += payloadSizeLen),
    );

    // check remaining size is correct
    final remaining = data.length - offset;
    final expectedRemaining = payloadSize + hashLen;
    if (remaining != expectedRemaining) {
      throw FileFormatException('File truncated or invalid payload length');
    }

    // read payload
    final payload = data.sublist(offset, offset += payloadSize);

    // read footer - payload hash
    final footerPayloadHash = data.sublist(offset, offset += hashLen);

    // verify payload hash
    var payloadDigest = sha256.convert(payload).bytes;
    if (!_listEquals(payloadDigest, footerPayloadHash))
      throw FileFormatException('Payload hash mismatch');

    return CampaignFileResult(payload: payload, flags: flags);
  }

  static List<int> _u32ToBytes(int v) {
    final b = ByteData(4)..setUint32(0, v, Endian.little);
    return b.buffer.asUint8List();
  }

  static int _bytesToU32(List<int> bytes) {
    final b = ByteData.sublistView(Uint8List.fromList(bytes));
    return b.getUint32(0, Endian.little);
  }

  static bool _listEquals(List<int> a, List<int> b) {
    if (a.length != b.length) return false;
    for (var i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }
}
