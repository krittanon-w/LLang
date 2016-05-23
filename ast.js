var postOrder = function(node){
  if(node != null){
    postOrder(node.left);
    postOrder(node.right);
    console.log(node.value);
   // if(node.value=='+') console.log('t');
  }
};
exports.postOrder = postOrder;

var preOrder = function(node){
  if(node != null){
    console.log(node.value);
    if(node.value=='+') console.log('t');
    preOrder(node.left);
    preOrder(node.right);
    // if(node.type!='number') console.log('_');
  }
};
exports.preOrder = preOrder;

var inOrder = function(node){
  if(node != null){
    inOrder(node.left);
    console.log(node.value);
    inOrder(node.right);
    if(node.type!='number') console.log('_');
  }
};


exports.inOrder = inOrder;