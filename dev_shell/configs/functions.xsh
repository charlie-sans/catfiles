def _findin(args):
    """Find files containing text"""
    if len(args) == 0:
        print("Usage: findin <text>")
        return
    $(grep -r @(args[0]) . --color=auto)
aliases['findin'] = _findin

def _venv(args):
    """Create and enter a Python virtual environment"""
    $(python3 -m venv venv)
    source venv/bin/activate
    print("Virtual environment activated!")
aliases['venv'] = _venv

def _dsize(args):
    """Quick directory size"""
    if len(args) > 0:
        $(du -sh @(args[0]))
    else:
        $(du -sh .)
aliases['dsize'] = _dsize