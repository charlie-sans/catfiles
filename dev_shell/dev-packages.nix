{ pkgs }:

let
  # list of repo-provided config files and where they should be placed in the user's environment
  configMappings = [
    { src = "configs/nvim/init.vim"; dest = "$HOME/.config/nvim/init.vim"; }
    { src = "configs/git/.gitconfig"; dest = "$HOME/.gitconfig"; }
    { src = "configs/xonsh/.xonshrc"; dest = "$HOME/.config/xonsh/.xonshrc"; }
  ];

  # produce shell commands that copy present repo files into place
  copyCmds = builtins.concatStringsSep "\n" (map (c:
    "if [ -f \"$PWD/" + c.src + "\" ]; then mkdir -p \"$(dirname " + c.dest + ")\"; cp \"$PWD/" + c.src + "\" \"" + c.dest + "\"; fi"
  ) configMappings);
in
{
  # List of additional packages to merge into the devShell packages
  extraPackages = with pkgs; [
    htop
    ripgrep
    fd
  ];

  # Optional shellHook text that will be injected into the flake's shellHook.
  # Use this to source local config files (e.g. configs/extra_env.sh) or run setup commands.
  shellHookText = ''
    # Source a repository-provided script if present
    if [ -f "$PWD/configs/extra_env.sh" ]; then
      . "$PWD/configs/extra_env.sh"
    fi

    # Copy repository-provided configs into place (only if present)
    ${copyCmds}

    echo "Loaded extra dev-packages and hooks from dev-packages.nix"
  '';
}
