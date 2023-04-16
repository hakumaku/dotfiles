import subprocess
from functools import lru_cache

from ghp.utils.parse import parse_version


@lru_cache(maxsize=8)
def get_command_version(
    cmds: tuple[str], pattern: str, *, strip_pattern: str | None = None
) -> str | None:
    try:
        result = subprocess.run(cmds, stdout=subprocess.PIPE)
    except FileNotFoundError:
        return None

    output = result.stdout.decode().split("\n")
    for line in output:
        parsed_line = parse_version(
            line.strip(), match_pattern=pattern, strip_pattern=strip_pattern
        )
        if parsed_line is not None:
            return parsed_line

    return None
