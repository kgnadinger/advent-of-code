import Foundation

public class Main {
  let serialNumber: Int
  public init(_ serialNumber: Int) {
    self.serialNumber = serialNumber
  }
  
  func findPowerFor(_ x: Int, y: Int) -> Int {
    let rackId = x + 10
    return (rackId * y + serialNumber) * rackId / 100 % 10 - 5
  }
  
  public func findLargestPower() -> (x: Int, y: Int, size: Int) {
    var summedAreaGrid = Array(repeating: Array(repeating: 0, count: 301), count: 301)
    
    for x in (1..<301) {
      for y in (1..<301) {
        summedAreaGrid[x][y] = findPowerFor(x, y: y)
          + summedAreaGrid[x][y - 1]
          + summedAreaGrid[x - 1][y]
          - summedAreaGrid[x - 1][y - 1]
      }
    }
    
    var maxTotalPower = 0
    var maxTotalX = 0
    var maxTotalY = 0
    var maxSize = 0
    
    for num in (1..<301) {
      for x in (num..<301) {
        for y in (num..<301) {
          let localPower = summedAreaGrid[x][y]
            - summedAreaGrid[x - num][y]
            - summedAreaGrid[x][y - num]
            + summedAreaGrid[x - num][y - num]
          if localPower > maxTotalPower {
            maxTotalPower = localPower
            maxTotalX = x - num + 1; maxTotalY = y - num + 1; maxSize = num
          }
        }
      }
    }
    return (x: maxTotalX, y: maxTotalY, size: maxSize)
  }
}
