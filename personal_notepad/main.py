class TreeNode:
    def __init__(self,val=0,left=None,right=None) :
        self.val=val
        self.left=left
        self.right=right
def sumOfLeftLeaves(root:TreeNode):
    result=root.left.val+root.right.val-root.val
    return result

def createTree(arr):
    if arr is None or len(arr)==0 or not arr[0].isnumeric():
        return None
    treeNodeQueue=[]
    integerQueue=[]
    
    for a in arr:
        integerQueue.append(a)
    treeNode=TreeNode(int(integerQueue.pop(0)))
    treeNodeQueue.append(treeNode)
    
    
    while integerQueue!=[]:
        leftVal=None if (integerQueue==[]) else integerQueue.pop(0)
        rightVal=None if (integerQueue==[]) else integerQueue.pop(0)
        current=treeNodeQueue.pop(0)
        
        if leftVal and leftVal.isnumeric():
            left=TreeNode(int(leftVal))
            current.left =left
            treeNodeQueue.append(left)
        if rightVal and rightVal.isnumeric():
            right=TreeNode(int(rightVal))
            current.right =right
            treeNodeQueue.append(right)
            
        return treeNode
    
if __name__=="__main__":
    line=input()
    components=line.strip().split(",")
    
    root=createTree(components)
    print(sumOfLeftLeaves(root))