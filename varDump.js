var varDump = function(obj, indent){
  if (indent == null) indent = 4;
  return JSON.stringify(obj, null, indent);
}
module.exports = varDump;