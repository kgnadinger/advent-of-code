import Foundation

public struct Particle {
  let x: Int
  let y: Int
  let vel_x: Int
  let vel_y: Int
  
  func position(atTime time: Int) -> Particle {
    let lx = (vel_x * time) + self.x
    let ly = (vel_y * time) + self.y
    return Particle(x: lx, y: ly, vel_x: vel_x, vel_y: vel_y)
  }
  
}
