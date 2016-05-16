var fs = require("fs");
var jison = require("jison");

var bnf = fs.readFileSync("ll.jison", "utf8");
var parser = new jison.Parser(bnf);
//var llp = parser.parser;
var input = "a*1";
console.log(parser.parse(input));
//module.exports = parser;