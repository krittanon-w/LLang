var fs = require("fs");
var jison = require("jison");
var varDump = require("./varDump.js");

var bnf = fs.readFileSync("ll.jison", "utf8");
var parser = new jison.Parser(bnf);

var input = "1-1;1+1;2+2;"
var output = parser.parse(input);
console.log(varDump(output));


module.exports = parser;

