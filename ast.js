var postOrder = function(node){
  if(node != null){
    postOrder(node.left);
    console.log(node.value);
    postOrder(node.right);
    if(node.type!='number') console.log('_');
  }
};

exports.postOrder = postOrder;