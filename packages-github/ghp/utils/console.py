def error(msg: str) -> str:
    return f"\033[93m{msg}\033[0m"


def good(msg: str) -> str:
    return f"\033[92m{msg}\033[0m"


def info(msg: str) -> str:
    return f"\033[94m{msg}\033[0m"
