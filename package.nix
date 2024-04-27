{ lib
, rustPlatform
}:

let
  src = lib.fileset.toSource {
    root = ./.;
    fileset = lib.fileset.unions [
      ./Cargo.toml
      ./Cargo.lock
      ./src
    ];
  };
  inherit (lib.importTOML "${src}/Cargo.toml") package;
in
rustPlatform.buildRustPackage {
  pname = package.name;
  inherit (package) version;

  inherit src;

  cargoLock.lockFile = "${src}/Cargo.lock";

  meta = {
    inherit (package) description;
    license = lib.licenses.agpl3Plus;
    mainProgram = package.name;
  };
}
