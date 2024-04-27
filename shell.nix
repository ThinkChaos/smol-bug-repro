{
  pkgs ? import (builtins.fetchTarball {
    name = "nixos-unstable-7bb2ccd";
    url = "https://github.com/nixos/nixpkgs/archive/7bb2ccd8cdc44c91edba16c48d2c8f331fb3d856.tar.gz";
    sha256 = "0ijqx995jw9i16f28whyjdll9b0nydmyl4n91bci2cgryxms7f8f";
  }) {}
}:

pkgs.mkShell {
  inputsFrom = [
    (pkgs.callPackage ./package.nix { })
    pkgs.rustPlatform
  ];

  RUST_BACKTRACE = 1;
  RUST_SRC_PATH = pkgs.rustPlatform.rustLibSrc;
}
