import Foundation

public func run() -> Int {
  let numberOfPlayers = 452
  let marbleTotal = 71250*100
  var playerScore: [Int: Int] = [:]
  var rootNode = Node(value: 0)
  var secondNode = Node(value: 1)
  rootNode.next = secondNode
  rootNode.previous = secondNode
  secondNode.previous = rootNode
  secondNode.next = rootNode
  var currentNode = secondNode
  
  func printBoard() {
    var descript = "\(rootNode.value) "
    var currentNode = rootNode.next!
    while (currentNode !== rootNode) {
      descript += "\(currentNode.value) "
      currentNode = currentNode.next!
    }
    print(descript)
  }
  
  printBoard()
  var player = 1
  
  for marble in (2...marbleTotal) {
    player = (player + 1) % numberOfPlayers
    if marble % 23 == 0 {
      if playerScore[player] == nil {
        playerScore[player] = marble
      } else {
        playerScore[player]! += marble
      }
      currentNode = currentNode.backward(7)
      playerScore[player]! += currentNode.value
      currentNode = currentNode.remove()
    } else {
      currentNode = currentNode.forward(2)
      currentNode = currentNode.insert(marble)
    }
  }
  
  var highScore = 0
  for (_, value) in playerScore {
    if value > highScore {
      highScore = value
    }
  }
  return highScore
}
