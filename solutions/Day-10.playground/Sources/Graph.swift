import Foundation
import UIKit

public class Graph {
  public var particles: [Particle]
  
  public init() {
    self.particles = []
  }
  
  func maxX() -> Int {
    return particles
      .map { $0.x }
      .sorted(by: { $0 > $1 })
      .first ?? 0
  }
  
  func maxY() -> Int {
    return particles
      .map { $0.y }
      .sorted(by: { $0 > $1 })
      .first ?? 0
  }
  
  public func minX() -> Int {
    return particles
      .map { $0.x }
      .sorted(by: { $0 < $1 })
      .first ?? 0
  }
  
  public func minY() -> Int {
    return particles
      .map { $0.y }
      .sorted(by: { $0 < $1 })
      .first ?? 0
  }
  
  func findParticle(withX x: Int, withY y: Int) -> Particle? {
    return particles.first(where: {
      ($0.x == x && $0.y == y)
    })
  }

  public var description: String {
    var graphString = ""
    for y in (minY()...maxY()) {
      for x in (minX()...maxX()) {
        if let _ = findParticle(withX: x, withY: y) {
          graphString += "."
        } else {
          graphString += " "
        }
      }
      graphString += "\n"
    }
    return graphString
  }
}
