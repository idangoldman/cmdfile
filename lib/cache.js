const fs = require('fs');

class Cache {
  static #instance;
  static CACHE_FILE = 'cache.json';
  static CONFIG_FILE = 'config.json';

  static get instance() {
    if (!Cache.#instance) {
      Cache.#instance = new Cache();
    }
    return Cache.#instance;
  }

  #cache = {};

  constructor() {
    if (Cache.#instance) {
      throw new Error('Cannot create multiple instances of Cache class');
    }

    try {
      this.#cache = JSON.parse(fs.readFileSync(Cache.CACHE_FILE));
    } catch (err) {
      this.#cache = {};
    }
  }

  get(key) {
    return this.#cache[key];
  }

  set(key, value) {
    this.#cache[key] = value;
    fs.writeFileSync(Cache.CACHE_FILE, JSON.stringify(this.#cache));
  }

  clear() {
    this.#cache = {};
    fs.writeFileSync(Cache.CACHE_FILE, JSON.stringify(this.#cache));
  }
}

module.exports = Cache.instance;
