{
  description = "meow meow";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};

        # Import the dev-packages.nix file to get extra packages and shell hooks
        # extra = import ./dev-packages.nix { inherit pkgs; };
      in
      {
        devShells.default = pkgs.mkShell {
          name = "meow-meow";
          packages = with pkgs; [
            # Core utilities
            git
            curl 
            wget
            gnused
            gnutar
            zip
            unzip
            direnv
            
            # Development tools
            python3
            nodejs
            rustup
            gcc
            
            hyfetch

            # Xonsh shell
            xonsh
           ]; ++ (extra.extraPackages or []);

          # Environment variables
          env = {
            EDITOR = "nano";
            VISUAL = "nano";
            XONSHRC = "$PWD/configs/.xonshrc";
          };
          
          # Shell hook to customize environment
          shellHook = ''
      
            ${extra.shellHookText or ""}
            exec ${pkgs.xonsh}/bin/xonsh
          '';
        };
      }
    );
}