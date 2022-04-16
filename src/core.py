import os
import sys

from src.config import setup as config_setup


def run():
    cmds = config_setup()
    args = sys.argv[1:]
    cmd = args.pop(0) if args else ""
    command = args.pop(0) if args else ""

    # os.system("uptime")
    # print(cmd, command, args)

    if command.startswith("-", 0, 1):
        args.insert(0, command)
        command = ""

    if cmd in cmds.keys():
        commands = (
            cmds[cmd]["commands"] if "commands" in cmds[cmd].keys() else cmds[cmd]
        )

        if command in commands.keys():
            actions = (
                commands[command]
                if isinstance(commands[command], list)
                else [commands[command]]
            )

            for action in actions:
                # print('#', action)
                os.system(action)

        else:
            print("action not found")

    else:
        print("command not found.")
