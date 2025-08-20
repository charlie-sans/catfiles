# Project-specific aliases
# aliases['proj1'] = 'cd ~/Development/project1 && source venv/bin/activate'
# aliases['proj2'] = 'cd ~/Development/project2 && npm start'
# TODO: setup actual project aliases

# Docker aliases
aliases['dps'] = 'docker ps'
aliases['dcu'] = 'docker-compose up'
aliases['dcd'] = 'docker-compose down'

# System monitoring
aliases['meminfo'] = 'free -h'
aliases['diskusage'] = 'df -h'


# --- Aliases ---
aliases['ll'] = 'ls -la'
aliases['cls'] = 'clear'
aliases['dev'] = 'cd ~/Development'
aliases['..'] = 'cd ..'
aliases['...'] = 'cd ../..'
aliases['grep'] = 'grep --color=auto'
aliases['quit'] = 'exit; exit'
aliases['']

# --- Git Shortcuts ---
aliases['gs'] = 'git status'
aliases['ga'] = 'git add'
aliases['gc'] = 'git commit -m'
aliases['gp'] = 'git push'
aliases['gl'] = 'git log --oneline --graph --decorate'

# --- ssh specific ---
if $IS_SSH_COMPATIBLE:
    aliases['ssh'] = 'ssh'
    aliases['sshconfig'] = 'nano ~/.ssh/config'
    aliases['sshd'] = 'sudo systemctl restart sshd'
    aliases['techbox'] = 'ssh charlie@techboxv2'

# --- Development Tools ---
aliases['py'] = 'python3'
aliases['pip'] = 'pip3'

# --- Custom Functions ---
def _mkcd(args):
    """Create directory and change to it"""
    from pathlib import Path
    if len(args) == 0:
        print("Usage: mkcd <directory>")
        return
    dir_path = Path(args[0])
    dir_path.mkdir(parents=True, exist_ok=True)
    import os
    os.chdir(str(dir_path))
aliases['mkcd'] = _mkcd

def _devenv(args):
    """Show development environment info"""
    print("Current environment:")
    print(f"Python: @($(python3 --version))")
    print(f"Node: @($(node --version 2>/dev/null || echo 'Not installed'))")
    print(f"Ruby: @($(ruby --version 2>/dev/null || echo 'Not installed'))")
aliases['devenv'] = _devenv
