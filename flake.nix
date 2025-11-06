{
  description = "Learning flake";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  outputs = { self, nixpkgs }:
    let
      systems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      forAllSystems = f: builtins.listToAttrs (map
        (system: {
          name = system;
          value = f system;
        })
        systems);
    in
    {
      devShells = forAllSystems (system:
        let pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
        in {
          default = pkgs.mkShell {
            packages = with pkgs; [
              # DevOps tools
              ansible
              kubectl
              opentofu
              packer
              fluxcd
              terragrunt
              # Secrets
              sops
              age
              # Lint / security / docs
              tflint
              ansible-lint
              molecule
              terraform-docs
              trivy
              tfsec
              # Convenience
              jq
              yq
            ];
            shellHook = ''
              # Banner
              printf "\033[38;5;39m[homelab-dev]\033[0m Tools loaded: ansible, tofu, terragrunt, sops, trivy, tfsec, syft, grype\n"

              # Only tweak prompt for interactive shells
              case "$-" in *i*) interactive=1;; *) interactive=0;; esac

              if [ "$interactive" = 1 ]; then
                if [ -n "$BASH_VERSION" ]; then
                  # Bash prompt with blue homelab + colored user@host:path
                  export PS1="\[\e[38;5;39m\][homelab-dev]\[\e[0m\] \[\e[32m\]\u\[\e[0m\]@\[\e[35m\]\h\[\e[0m\]:\[\e[36m\]\w\[\e[0m\]\\$ "
                elif [ -n "$ZSH_VERSION" ]; then
                  # Zsh prompt with blue homelab + colored user@host:path
                  export PROMPT="%F{39}[homelab-dev]%f %F{green}%n%f@%F{magenta}%m%f:%F{cyan}%~%f %# "
                fi
              fi
            '';
          };
        });

    };
}
