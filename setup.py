from setuptools import setup

setup(
  author_email="idan@123code.co",
  author="Idan Goldman",
  description="command line task tool by 123Code.",
  license="MIT",
  name="cmd",
  platform="any",
  url="https://github.com/123code-il/cmd",
  version="0.1.0",

  scripts=["bin/cmd"],
  package_dir={'': './'},
  py_modules=["cmd"],

  keywords=[
    "cmd",
    "comandline",
    "comand line",
    "tasks"
  ],

  install_requires=[
    "deepmerge == 1.0.1",
    "pyyaml == 6.0",
    "toml == 0.10.2"
  ],

  extras_require = {
    "dev": [
      "black == 22.10.0",
      "pylint == 2.15.4",
      "twine == 4.0.1",
    ]
  }
)
