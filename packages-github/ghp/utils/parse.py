import re


def parse_version(
    string: str, *, match_pattern: str, strip_pattern: str | None = None
) -> str | None:
    if strip_pattern:
        string = re.sub(strip_pattern, "", string)

    result = re.search(match_pattern, string)
    if result is None:
        return None

    return result.group(1)
