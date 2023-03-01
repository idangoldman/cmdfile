const fs = require('fs');
const path = require('path');
const yaml = require('js-yaml');
const toml = require('toml');
const { promisify } = require('util');
const readFile = promisify(fs.readFile);
const writeFile = promisify(fs.writeFile);

class Config {
  constructor() {
    if (!Config.instance) {
      Config.instance = this;

      this.config = {};
      this.cmdFile = 'cmdfile.yml';
      this.cmdFileExtension = path.extname(this.cmdFile)

      this.readConfig();
    }
    return Config.instance;
  }

  async readConfig() {
    try {
      const data = await readFile(path.join(__dirname, this.cmdFile), 'utf8');

      switch (this.cmdFileExtension) {
        case '.yaml':
        case '.yml':
          this.config = yaml.safeLoad(data);
          break;
        case '.toml':
          this.config = toml.parse(data);
          break;
        case '.json':
          this.config = JSON.parse(data);
          break;
        default:
          throw new Error(`Unsupported cmdfile extension: ${this.cmdFileExtension}`);
      }
    } catch (err) {
      console.error(err);
    }
  }

  async writeConfig() {
    try {
      let data;

      switch (this.cmdFileExtension) {
        case '.yaml':
        case '.yml':
          data = yaml.safeDump(this.config);
          break;
        case '.toml':
          data = toml.stringify(this.config);
          break;
        case '.json':
          data = JSON.stringify(this.config);
          break;
        default:
          throw new Error(`Unsupported cmdfile extension: ${this.cmdFileExtension}`);
      }

      await writeFile(path.join(__dirname, this.cmdFile), data);
    } catch (err) {
      console.error(err);
    }
  }

  get(key) {
    return this.config[key];
  }

  set(key, value) {
    this.config[key] = value;
    this.writeConfig();
  }

  remove(key) {
    delete this.config[key];
    this.writeConfig();
  }

  clear() {
    this.config = {};
    this.writeConfig();
  }
}

const config = new Config();
Object.freeze(config);

module.exports = config;
