{
  description = "Moonmist Bazzite custom image";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{ self, ... }:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
      ];
      perSystem =
        { pkgs, ... }:
        {
          devShells = {
            default = pkgs.mkShellNoCC {
              name = "moonmist";
              packages = with pkgs; [
                cosign
              ];
            };
          };
        };
    };
}
