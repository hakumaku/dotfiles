from typing import Dict, List

from libqtile.widget import Image
from libqtile.config import Group, Match


def create_groups(names: List[str], rules: Dict[int, List[Match]]) -> List[Group]:
    groups = [
        Group(name=str(index), label=name, matches=rules.get(index, None)) for index, name in enumerate(names, start=1)
    ]
    # image = Image(filename="/home/haku/.config/awesome/wibar/icons/audio-volume-high-symbolic.svg")
    # groups[0] = Group(name="1", label="foo", matches=rules.get(1, None))

    return groups
