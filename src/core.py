import logging
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
        actions = []

        if isinstance(cmds[cmd], dict):
            if (
                "commands" in cmds[cmd].keys()
                and command in cmds[cmd]["commands"].keys()
            ):
                actions = (
                    cmds[cmd]["commands"][command]
                    if isinstance(cmds[cmd]["commands"][command], list)
                    else [cmds[cmd]["commands"][command]]
                )

            elif "command" in cmds[cmd].keys():
                actions = (
                    cmds[cmd]["command"]
                    if isinstance(cmds[cmd]["command"], list)
                    else [cmds[cmd]["command"]]
                )
        elif isinstance(cmds[cmd], str):
            actions = [cmds[cmd]]
        else:
            actions = cmds[cmd]

        for action in actions or []:
            # logging.debug('#', action)
            os.system(action)

        if not actions:
            logging.error("action not found.")

    else:
        logging.error("command not found.")
