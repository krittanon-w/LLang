// include
var fs = require("fs");
var path = require('path');


// init
const file = path.join(__dirname,'ass.txt');
var stack = [];

// function
var file_fs = function(content){
  fs.writeFile(file, content, function(err) {
    if(err) {
      return console.log(err);
    }
  });
}







exports.add = function(op_l,op_r){
    return `add ${op_l}, ${op_r}`;
}

exports.add = function(op_l,op_r){
    return `sub ${op_l}, ${op_r}`;
}

exports.multi = function(op_l,op_r){
    return `sub ${op_l}, ${op_r}`;
}

exports.divide = function(op_l,op_r){
    return `sub ${op_l}, ${op_r}`;
}

exports.mod = function(op_l,op_r){
    return `sub ${op_l}, ${op_r}`;
}

exports.add = function(op_l,op_r){
    return `sub ${op_l}, ${op_r}`;
}


void GenerateCode(tree t, int resultRegNum)
{
if (IsArithmeticOp(t->label)) {
GenerateCode(t->left, resultRegNum);
GenerateCode(t->right, resultRegNum + 1);
GenerateArithmeticOp(t->label, resultRegNum, resultRegNum + 1);
} else {
GenerateLoad(t->label, resultRegNum);
}
}
bool IsArithmeticOp(char ch)
{
return ((ch == '+') || (ch == '-') || (ch == '*') || (ch == '/'));
}
void GenerateArithmeticOp(char op, int reg1, int reg2)
{
char *opCode;
switch (op) {
case '+': opCode = "ADD";
break;
case '-': opCode = "SUB";
break;
case '*': opCode = "MUL";
break;
case '/': opCode = "DIV";
break;
}
printf("%s R%d, R%d\n", opCode, reg1, reg2);
}
void GenerateLoad(char c, int reg)
{
printf("LOAD %c, R%d\n",c , reg);
}


var isArith = function(opr){
  if(['+','-','*','/'].indexOf(opr)>-1) return true;
  else return false;
}

var genLoad = function(char,reg){
  return `LOAD ${c},${reg}`;
}

var genArithOp = function(opr){
  var opCode;
  switch(opr) {
    case '+': opCode = 'ADD';
    break;
    case '-': opCode = 'SUB';
    break;
    case '*': opCode = 'MUL';
    break;
    case '/': opCode = 'DIV';
    break;
    default:
        default code block
}
}