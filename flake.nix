{
  description = "Learning flake";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  outputs = { self, nixpkgs }:
  let
    systems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
    forAllSystems = f: builtins.listToAttrs (map (system: {
      name = system;
      value = f system;
    }) systems);
  in {
    devShells = forAllSystems (system:
      let pkgs = import nixpkgs { inherit system; config.allowUnfree = true;};
      in {
        default = pkgs.mkShell {
          packages = with pkgs; [ 
            # Devops tools
            ansible 
            kubectl
            opentofu
            ansible
            packer
            fluxcd
            # Linter and test
            tflint
            molecule
          ];
        };
      });

  };
}

