[Setup]
AppId=b185e47c-2e2c-4338-97fe-5be0ff22962f
AppName=Combat Tracker
AppVersion=0.3.0
DefaultDirName={pf}\Combat Tracker
DefaultGroupName=Combat Tracker
OutputDir=D:\combat-tracker\Installer
OutputBaseFilename=Combat Tracker Setup
Compression=lzma
SolidCompression=yes
WizardStyle=dynamic

[Files]
Source: "D:\combat-tracker\ReleaseFiles\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs

[Icons]
Name: "{group}\Combat Tracker"; Filename: "{app}\combat_tracker.exe"

[Run]
Filename: "{app}\combat_tracker.exe"; Description: "Launch Combat Tracker"; Flags: nowait postinstall skipifsilent