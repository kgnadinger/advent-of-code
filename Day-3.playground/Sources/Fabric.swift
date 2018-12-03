import Foundation

public class Fabric {
  public typealias Claims = (count: Int, ids: [String])
  public var fabricMatrix: [Int: [Int: Claims]]
  public var overlappingClaimsCount = 0
  public var idsThatOverlap: [String]
  public var claimIds: [String]
  
  public init() {
    self.fabricMatrix = [Int: [Int: Claims]]()
    self.claimIds = []
    self.idsThatOverlap = []
  }
  
  public func insertClaim(forId id: String, forRow row: Int, column: Int, width: Int, height: Int) {
    claimIds.append(id)
    for rowNum in (row...(height + row - 1)) {
      for colNum in (column...(width + column - 1)) {
        if let _ = fabricMatrix[rowNum] {
          if let _ = fabricMatrix[rowNum]![colNum] {
            fabricMatrix[rowNum]![colNum]!.count += 1
            fabricMatrix[rowNum]![colNum]!.ids.append(id)
            if fabricMatrix[rowNum]![colNum]!.count == 2 {
              overlappingClaimsCount += 1
            }
            if fabricMatrix[rowNum]![colNum]!.count > 1 {
              for foundId in fabricMatrix[rowNum]![colNum]!.ids {
                if idsThatOverlap.firstIndex(of: foundId) == nil {
                  idsThatOverlap.append(foundId)
                }
              }
            }
          } else {
            fabricMatrix[rowNum]![colNum] = (count: 1, ids: [id])
          }
        } else {
          fabricMatrix[rowNum] = [colNum: (count: 1, ids: [id])]
        }
      }
    }
  }
  
  public func sanitizeClaimIds() -> [String] {
    for id in idsThatOverlap {
      if let index = claimIds.firstIndex(of: id) {
        claimIds.remove(at: index)
      }
    }
    return claimIds
  }
}
