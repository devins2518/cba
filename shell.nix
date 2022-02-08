{ pkgs ? import <nixpkgs> { } }:
let frameworks = pkgs.darwin.apple_sdk.frameworks;
in pkgs.mkShell {
  nativeBuildInputs = with pkgs;
    [ pkg-config libffi SDL2 SDL2_image SDL2_mixer SDL2_ttf ]
    ++ lib.optionals stdenv.isDarwin [
      frameworks.CoreAudio
      frameworks.AudioUnit
      frameworks.Cocoa
      frameworks.CoreAudio
      frameworks.CoreServices
      frameworks.ForceFeedback
      frameworks.OpenGL
    ];
}
