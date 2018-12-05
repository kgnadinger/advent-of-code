import Foundation

public class Main {
  public let fabric: Fabric
  public let splitInput: [String.SubSequence]
  
  public init(fabric: Fabric, input: [String.SubSequence]) {
    self.fabric = fabric
    self.splitInput = input
  }
  
  public func run() -> (claimCount: Int, unoverlappingClaims: [String]) {
    for input in splitInput {
      let inputArray = input.split(separator: " ")
      let id = String(inputArray.first!)
      let column = Int(inputArray[2].split(separator: ",").first!)! + 1
      let row = Int(inputArray[2].split(separator: ",").last!.split(separator: ":").first!)! + 1
      let width = Int(inputArray.last!.split(separator: "x").first!)!
      let height = Int(inputArray.last!.split(separator: "x").last!)!
      fabric.insertClaim(forId: id, forRow: row, column: column, width: width, height: height)
    }
    let ids = fabric.sanitizeClaimIds()
    return (claimCount: fabric.overlappingClaimsCount, unoverlappingClaims: ids)
  }
}
