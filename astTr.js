exports.postOrder = function(node){
  if(node != null){
    postOrder(node.arguments[0]);
    postOrder(node.arguments[2]);
    if(node.atguments.length==1){
      console.log(node.arguments[0]);
    }
  }
};