import fs from "fs";
import path from "path";
import YAML from "yaml";
import { Jsonnet } from "@hanazuki/node-jsonnet";

export const toYAML = async (filename, content) => {
  try {
    const jsonn = new Jsonnet();
    const json = await jsonn.evaluateSnippet(content);
    const jsObject = JSON.parse(json);
    const yml = YAML.stringify(jsObject);
    fs.writeFileSync(filename + ".yml", yml);
  } catch (err) {
    console.error(`File ${filename} is not a valid jsonnet file:`, err);
  }
};

export const toJsonnet = async (filename, content) => {
  try {
    const jsObject = YAML.parse(content);
    const jsonnetContent = JSON.stringify(jsObject, null, 2).replace(
      /"([^"]+)":/g,
      "$1:"
    );
    fs.writeFileSync(filename + ".jsonnet", jsonnetContent);
  } catch (err) {
    console.error(`File ${filename} is not a valid yaml file:`, err);
  }
};

const args = process.argv.slice(2);
const input = args[0];
const output =
  path.dirname(input) + "/" + path.basename(input, path.extname(input));
const ext = path.extname(input);

const convert = async (input, output, ext) => {
  if (!fs.existsSync(input)) {
    console.error(`File ${input} does not exist`);
  }

  const content = fs.readFileSync(input, "utf8");
  if (!content) {
    console.error(`File ${input} is empty`);
  }

  switch (ext) {
    case ".jsonnet":
      await toYAML(input, content);
      break;
    case ".yml":
      await toJsonnet(input, content);
      break;
    default:
      console.error(`File ${input} is not a jsonnet or yaml file`);
  }
};

convert(input, output, ext);
// usage: node convertor.js input.jsonnet
// usage: node convertor.js input.yml
