import Foundation
import UIKit


public class Main {
  var particles: [Particle] = []
  let input: [String]
  
  public init(input: [String]) {
    self.input = input
    setup()
  }

  public func setup() {
    for dataString in input {
      let serializedDataString = dataString.inputs()
      let positionArray = serializedDataString[0]
        .replacingOccurrences(of: "<", with: "")
        .replacingOccurrences(of: ">", with: "")
        .split(separator: ",").map { String($0)}
      let x = Int(positionArray.first!.replacingOccurrences(of: " ", with: ""))!
      let y = Int(positionArray.last!.replacingOccurrences(of: " ", with: ""))!
      let vectorArray = serializedDataString[1]
        .replacingOccurrences(of: "<", with: "")
        .replacingOccurrences(of: ">", with: "")
        .split(separator: ",").map { String($0)}
      let vel_x = Int(vectorArray.first!.replacingOccurrences(of: " ", with: ""))!
      let vel_y = Int(vectorArray.last!.replacingOccurrences(of: " ", with: ""))!
      let particle = Particle(x: x, y: y, vel_x: vel_x, vel_y: vel_y)
      particles.append(particle)
    }
  }

  public func findSmallestArea() -> Int {
    var smallestArea: Int = 10000*10000
    var smallestIteration = 0
    for i in (0...20000) {
      let newGraph = Graph()
      newGraph.particles = particles.map { $0.position(atTime: i) }
      let width = newGraph.maxX() - newGraph.minX()
      let height = newGraph.maxY() - newGraph.minY()
      let area = width * height
      if area < smallestArea {
        smallestArea = area
        smallestIteration = i
      }
    }
    return smallestIteration
  }
  
  public func graph() -> Graph {
    let time = findSmallestArea()
    let newGraph = Graph()
    newGraph.particles = particles.map { $0.position(atTime: time) }
    return newGraph
  }
}



public extension String
{
  func inputs() -> [String]
  {
    let regrexPattern = "\\<.*?\\>"
    let regex = try! NSRegularExpression(pattern: regrexPattern, options: NSRegularExpression.Options.caseInsensitive)
    let string = self as NSString
    return regex.matches(in: self, options: [], range: NSRange(location: 0, length: string.length)).map {
      string.substring(with: $0.range)
    }
  }
}
