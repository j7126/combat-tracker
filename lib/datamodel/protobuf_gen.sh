SRC_DIR="./"
for f in *.proto; do
    protoc -I=$SRC_DIR --dart_out=$SRC_DIR "$SRC_DIR/$f"
done
