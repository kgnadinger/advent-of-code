import Foundation

public class Node {
  public var value: Int
  public var previous: Node?
  public var next: Node?
  
  public init(value: Int) {
    self.value = value
  }
  
  public func insert(_ value: Int) -> Node {
    let newNode = Node(value: value)
    newNode.next = self
    newNode.previous = self.previous
    self.previous!.next = newNode
    self.previous = newNode
    return newNode
  }
  
  public func remove() -> Node {
    let nextNode = self.next!
    nextNode.previous = self.previous
    self.previous!.next = nextNode
    return nextNode
  }
  
  public func forward(_ steps: Int) -> Node {
    var node = self
    for _ in (0..<steps) {
      node = node.next!
    }
    return node
  }
  
  public func backward(_ steps: Int) -> Node {
    var node = self
    for _ in (0..<steps) {
      node = node.previous!
    }
    return node
  }
}
