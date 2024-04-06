"""
high level support for doing this and that.
"""

import unittest
from ..src.core import run

class CmdTests(unittest.TestCase):
  def test_run(self):
    assert run('cmd docker restart') == ' && '.join([
      'docker-compose down',
      'docker-compose up -d'
    ])

  def test_multiliner_cmd(self):
    assert run('cmd brew up') == ' && '.join([
      'brew update',
      'brew upgrade --greedy',
      'brew upgrade --cask --greedy',
      'brew cleanup',
      'brew doctor'
    ])

  def test_sudo(self):
    assert run('cmd apt up') == 'sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y'

  def test_parameters(self):
    cmd_equals_to = 'sqlite3 ./database/development.db .schema > schema.sql'
    cmd_dev = 'cmd sqlite schema DB_FILE=./database/development.db'

    assert run('cmd sqlite schema') == cmd_equals_to
    assert run('cmd sqlite schema ./database/development.db schema.sql') == cmd_equals_to
    assert run(cmd_dev) == cmd_equals_to
    assert run(f"{cmd_dev} DB_SCHEMA=schema.sql") == cmd_equals_to
    assert run('cmd sqlite schema ./database/development.db') == 'Expected 2 parameters and got 1'
    assert run('cmd sqlite schema DB_SCHEMA=schema.sql') == 'Parameters DB_FILE not found'

  def test_run_in_context(self):
    assert run('cmd git init --path=/home/user/new_project') == ' && '.join([
      'cd /home/user/new_project',
      'git add .',
      'git commit -m "Initial commit."'
    ])
