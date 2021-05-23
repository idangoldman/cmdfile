#!/usr/bin/env python3

import os
import re
import pathlib
import sys
import yaml
import json
import toml
from deepmerge import always_merger

def find_cmd_file_paths(search_for = '^cmd\.(yml|json|toml)$', folder = '.'):
  folder_path = os.path.abspath(folder)
  cmd_file = ''
  cmd_files = [file for file in os.listdir(folder_path) if re.match(search_for, file)]
  parent_folders = []
  found_paths = []

  if (1 == len(cmd_files)):
    cmd_file = os.path.join(folder_path, cmd_files.pop())
    found_paths.append(cmd_file)

  elif (1 < len(cmd_files)):
    print('In this folder there is mroe than one CONFIG FILE. Folder Path:', folder_path)
    sys.exit(1)

  if '/' != folder_path and str(pathlib.Path.home()) != folder_path:
    parent_folder = pathlib.Path(folder_path).parent.absolute()
    parent_folders = find_cmd_file_paths(folder = parent_folder)

    if 0 != len(parent_folders):
      found_paths.append(*parent_folders)

  return found_paths

def cmd_file_loader(file_path=''):
  with open(file_path, 'r') as content:
    file_suffix = pathlib.Path(file_path).suffix[1:]

    try:
      if file_suffix in ['yml', 'yaml']:
        config = yaml.full_load(content)

      elif file_suffix == 'json':
        config = json.loads(content.read())

      elif file_suffix == 'toml':
        config = toml.loads(content)

    except:
      print('CONFIG FILE:', file_path, 'is invalid')
      sys.exit(1)

  return config

def setup():
  cmd_options = []
  cmd_file_paths = find_cmd_file_paths()
  cmd_file_default_path = os.path.join(pathlib.Path(__file__).parent.parent.absolute(), 'cmd.yml')

  if not cmd_file_default_path in cmd_file_paths:
    cmd_file_paths.append(cmd_file_default_path)

  for cmd_file_path in cmd_file_paths:
    options = cmd_file_loader(cmd_file_path)
    cmd_options = always_merger.merge(cmd_options, options)

  return cmd_options
