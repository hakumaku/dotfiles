#!/usr/bin/env bash

sudo apt install python3-venv
python3 -m pip install --user pipx
python3 -m userpath append ~/.local/bin
pipx install gdbgui
