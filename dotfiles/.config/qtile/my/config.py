from typing import Dict, List

from libqtile.config import Group, Key, Match

from my.core.float_rules import create_float_rules
from my.core.groups import create_groups
from my.core.keys import create_keys


class Config:
    def __init__(self, mod: str, terminal: str, group_names: List[str], group_rules: Dict[int, List[Match]]):
        self.mod = mod
        self.terminal = terminal
        self.group_names = group_names
        self.group_rules = group_rules

        self._groups = create_groups(group_names, group_rules)
        self._keys = create_keys(self.mod, self.terminal, self._groups)

    @property
    def keys(self) -> List[Key]:
        return self._keys

    @property
    def groups(self) -> List[Group]:
        return self._groups

    @property
    def float_rules(self) -> List[Match]:
        return create_float_rules()
