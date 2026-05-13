"""Helpers for resolving paths used by the demo scripts.

External library paths (HYBRID, TRANSFORM) live in `paths.txt` next to this file
so they can be edited per user without touching the scripts.
"""
import os


def load_paths(filename="paths.txt"):
    """Read key=value pairs from `paths.txt` (alongside this file)."""
    config_file = os.path.join(os.path.dirname(os.path.abspath(__file__)), filename)
    paths = {}
    with open(config_file) as f:
        for line in f:
            line = line.strip()
            if not line or line.startswith("#"):
                continue
            key, _, value = line.partition("=")
            paths[key.strip()] = value.strip()
    return paths


def abs_wd(wd):
    """Dymola needs an absolute forward-slash path for setWorkDirectory and .mat reads."""
    os.makedirs(wd, exist_ok=True)
    return os.path.abspath(wd).replace("\\", "/")
