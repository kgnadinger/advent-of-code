import Foundation

public struct Coordinate: CustomStringConvertible {
  let id: Int
  public let x: Int
  public let y: Int
  
  public init(id: Int, x: Int, y: Int) {
    self.id = id
    self.x = x
    self.y = y
  }
  
  public var description: String {
    return "Id: \(id), Coordinate: (\(x), \(y))"
  }
  
  public func distanceFrom(coordinatePoint coordinate: (x: Int, y: Int)) -> Int {
    return abs(coordinate.x - x) + abs(coordinate.y - y)
  }
}
