import Foundation

public class Plant: CustomStringConvertible {
  public var hasPlant: State
  public var original: Bool
  
  public init(_ state: String) {
    self.hasPlant = State(rawValue: state)!
    self.original = false
  }
  
  public enum State: String {
    case hasPlant = "#"
    case hasNoPlant = "."
  }
  
  public var description: String {
    return hasPlant.rawValue
  }
}
