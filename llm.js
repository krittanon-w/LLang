var fs = require("fs");
var jison = require("jison");
var varDump = require("./varDump.js");

var bnf = fs.readFileSync("ll.jison", "utf8");
var input = fs.readFileSync("lll.ll", "utf8");
var parser = new jison.Parser(bnf);

var output = parser.parse(input);
console.log(varDump(output));

module.exports = parser;