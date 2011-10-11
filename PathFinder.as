package {
    
    public class PathFinder {
        
        public static const COST_STRAIGHT_MOVE:int = 10;
        public static const COST_DIAGONAL_MOVE:int = 14;
        public static const NUM_SURROUNDING_NODES:int = 8;
        
        public var grid:Array;
        
        public var startingPosition:Object;
        public var endingPosition:Object;
        
        /**
         *List of nodes tha will be analysed
        */
        public var openList:Array;
        /**
         *List of nodes already analysed
        */
        public var closedList:Array;
        
        public var node:Object;
        
        public function PathFinder(grid:Array) {
            this.grid = grid;
        }
        
        public function createNode(parent:Object, x:int, y:int, G:int):Object {
            var newNode:Object = new Object();
            newNode.x = x;
            newNode.y = y;
            newNode.parent = parent;
            if (parent == null) {
                newNode.G = 0;
            } else {
                newNode.G = newNode.parent.G + G;
            }
            
            var H:int = (Math.abs(newNode.x - endingPosition.x) +
                Math.abs(newNode.y - endingPosition.y)) * COST_STRAIGHT_MOVE;
            newNode.H = H;
            newNode.F = newNode.G + newNode.H;
            return newNode;
        }
        
        public function pathHasBeenFound():Boolean {
            var lengthClosedList:int = closedList.length;
            if (! (lengthClosedList > 0)) {
                return false;
            }
            node = closedList[lengthClosedList - 1];
            return (node.x == endingPosition.x) && (node.y == endingPosition.y);
        }
        
        public function getNodeWithLowestFCost():Object {
            var lengthOpenList:int = openList.length;
            var lowest:int = openList[0].F;
            var index:int = 0;
            for(var i:int = 1; i < lengthOpenList; i++) {
                node = openList[i];
                if (node.F < lowest) {
                    lowest = node.F;
                    index = i;
                }
            }
            return openList[index];
        }
        
        public function removeNodeFromOpenList(theNode:Object):void {
            var index:int = openList.indexOf(theNode);
            openList.splice(index, 1);
        }
        
        public function addNodeToClosedList(theNode:Object):void {
            closedList.push(theNode);
        }
        
        public function isNodeInClosedList(x:int, y:int):Boolean {
            var lengthClosedList:int = closedList.length;
            for(var i:int = 0; i < lengthClosedList; i++) {
                node = closedList[i];
                if ((node.x == x) && (node.y == y)) {
                    return true;
                }
            }
            return false;
        }
        
        public function isNodeInOpenList(x:int, y:int):Boolean {
            var lengthOpenList:int = openList.length;
            for(var i:int = 0; i < lengthOpenList; i++) {
                node = openList[i];
                if ((node.x == x) && (node.y == y)) {
                    return true;
                }
            }
            return false;
        }
        
        public function isWalkableNode(x:int, y:int):Boolean {
            if ((grid[y] == undefined) || (grid[y] == null)) {
                return false;
            }
            
            var nodeValue:int = grid[y][x];
            if (nodeValue == 1) {
                return false;
            }
            if (isNodeInClosedList(x, y)) {
                return false;
            }
            
            return true;
        }
        
        /**
         *Tells if the node indicated by x and y coordinates is unwalkable.
        */
        public function isUnwalkableNode(x:int, y:int):Boolean {
            if ((grid[y] == undefined) || (grid[y] == null)) {
                return true;
            }
            
            var nodeValue:int = grid[y][x];
            if (nodeValue == 1) {
                return true;
            }
            return false;
        }
        
        public function defineGCost(relativeX:int, relativeY:int):int {
            var sum:int = Math.abs(relativeX + relativeY);
            //means that the node is diagonal to it's parent node
            if (sum == 2 || sum == 0) {
                return COST_DIAGONAL_MOVE;
            }
            return COST_STRAIGHT_MOVE;
            
        }
        
        public function getNodeFromOpenList(x:int, y:int):Object {
            var lengthOpenList:int = openList.length;
            for(var i:int = 0; i < lengthOpenList; i++) {
                node = openList[i];
                if ((node.x == x) && (node.y == y)) {
                    return node;
                }
            }
            return null;
        }
        
        /**
         *Tell if the node indicated by relativeX and relativeY coordinates is a diagonal node
         *relative to currentNodeX and currentNodeY coordinates and if there is a unwalkable
         *node nearby.
        */
        public function isDiagonalNode(relativeX:int, relativeY:int,
            currentNodeX:int, currentNodeY:int):Boolean {
            
            //just confirming if the node is in the diagonal position from the current node
            var isDiagonal:Boolean = ((relativeX == -1 && relativeY == -1) ||
                (relativeX == 1 && relativeY == -1) ||
                (relativeX == 1 && relativeY == 1) ||
                (relativeX == -1 && relativeY == 1));
            if (! isDiagonal) {
                return false;
            }
            
            var isUnwalkable:Boolean = false;
            if (relativeX == -1 && relativeY == -1) {
                isUnwalkable = isUnwalkableNode(currentNodeX + 0, currentNodeY -1)
                    || isUnwalkableNode(currentNodeX -1, currentNodeY + 0);
            } else if (relativeX == 1 && relativeY == -1) {
                isUnwalkable = isUnwalkableNode(currentNodeX + 0, currentNodeY -1)
                    || isUnwalkableNode(currentNodeX + 1, currentNodeY + 0);
            } else if (relativeX == 1 && relativeY == 1) {
                isUnwalkable = isUnwalkableNode(currentNodeX + 1, currentNodeY + 0)
                    || isUnwalkableNode(currentNodeX + 0, currentNodeY + 1);
            } else if (relativeX == -1 && relativeY == 1) {
                isUnwalkable = isUnwalkableNode(currentNodeX - 1, currentNodeY + 0)
                    || isUnwalkableNode(currentNodeX + 0, currentNodeY + 1);
            }
            
            return isUnwalkable;
            
            
        }
        
        public function calcPath(startingPosition:Object, endingPosition:Object):Array {
            this.startingPosition = startingPosition;
            this.endingPosition = endingPosition;
            
            var colList:Array = [-1, 0, 1, 1, 1, 0, -1, -1];
            var rowList:Array = [-1, -1, -1, 0, 1, 1, 1, 0];
            openList = new Array();
            closedList = new Array();
            
            var startingNode:Object = createNode(null, startingPosition.x,
                startingPosition.y, 0);
            openList.push(startingNode);
            
            while((openList.length > 0) && (! pathHasBeenFound())) {
                var currentNode:Object = getNodeWithLowestFCost();
                removeNodeFromOpenList(currentNode);
                addNodeToClosedList(currentNode);
                for(var i:int = 0; i < NUM_SURROUNDING_NODES; i++) {
                    var x:int = currentNode.x + colList[i];
                    var y:int = currentNode.y + rowList[i];
                    
                    //this verification makes the path move around corners and not
                    //cut across the corner of a nearby unwalkable node
                    if (isDiagonalNode(colList[i], rowList[i], currentNode.x,
                        currentNode.y)) {
                        
                        continue;
                    }
                    
                    if (! isWalkableNode(x, y)) {
                        continue;
                    }
                    var gCost:int = defineGCost(colList[i], rowList[i]);
                    if (! isNodeInOpenList(x, y)) {
                        var newNode:Object = createNode(currentNode, x, y, gCost);
                        openList.push(newNode);
                        continue;
                    }
                    node = getNodeFromOpenList(x, y);
                    var betterPath:Boolean = (currentNode.G + gCost) < node.G;
                    if (betterPath) {
                        removeNodeFromOpenList(node);
                        node = createNode(currentNode, x, y, gCost);
                        openList.push(node);
                    }
                }
                
            }
            var path:Array = new Array();
            if (! pathHasBeenFound()) {
                //trace("path not found!");
                return path;
            }
            var targetNode:Object = closedList[closedList.length - 1];
            
            node = targetNode;
            while(node != null) {
                path.push(node);
                node = node.parent;
            }
            //reverse the array to return the path from the "beginning"
            return path.reverse();
        }
        
    }
    
}