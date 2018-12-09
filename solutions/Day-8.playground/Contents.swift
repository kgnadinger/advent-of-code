import Foundation

let fileURL = Bundle.main.url(forResource: "input", withExtension: "txt")
var content = try String(contentsOf: fileURL!, encoding: String.Encoding.utf8)
content.popLast()
var input = content.split(separator: " ").map { Int(String($0))! }



class Node: CustomStringConvertible {
  let childNodeQuantity: Int
  let metaDataNodeQuantity: Int
  var nodes: [Node]
  var metaData: [Int]
  
  public init(childNodeQuantity: Int, metaDataNodeQuantity: Int) {
    self.childNodeQuantity = childNodeQuantity
    self.metaDataNodeQuantity = metaDataNodeQuantity
    self.nodes = []
    self.metaData = []
  }
  
  public func add(metaData data:Int) {
    self.metaData.append(data)
  }
  
  public func sumMetaData() -> Int {
    var metaDataSum = metaData.reduce(0,+)
    for node in nodes {
      metaDataSum += node.sumMetaData()
    }
    return metaDataSum
  }
  
  public var value: Int {
    get {
      if (nodes.isEmpty) {
        return metaData.reduce(0,+)
      } else {
        var valueSum = 0
        for entry in metaData {
          if entry <= nodes.count {
            let value = nodes[entry-1].value
            valueSum += value
          }
        }
        return valueSum
      }
    }
  }
  
  public var count: String {
    get {
      var returnString = ""
      returnString += "\(nodes.count)-->"
      for node in nodes {
        returnString += node.count
      }
      return returnString
    }
  }
  
  public var description: String {
    return "Nodes: \(nodes.count), MetaData: \(metaData)"
  }
}

func parseNewNode() -> Node {
  let nodeChildQuant = input.removeFirst()
  let nodeMetaDataQuant = input.removeFirst()
  var newNode = Node(childNodeQuantity: nodeChildQuant, metaDataNodeQuantity: nodeMetaDataQuant)
  if nodeChildQuant > 0 {
    for _ in (1...nodeChildQuant) {
      newNode.nodes.append(parseNewNode())
    }
  }

  for _ in (1...nodeMetaDataQuant) {
    newNode.add(metaData: input.removeFirst())
  }
  
  return newNode
}

let rootNode = parseNewNode()
print(rootNode)
// Problem 1
print(rootNode.sumMetaData())

// Problem 2
print("Value: \(rootNode.value)")


