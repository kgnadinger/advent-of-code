import Foundation

public class Main {
  // 353 x 353
  public var coordinateHash = [Int: [Int: Coordinate?]]()
  public var distanceHash = [Int: [Int: Int]]()
  public let coordinates: [Coordinate]
  
  public init(coordinates: [Coordinate]) {
    self.coordinates = coordinates
  }

  func findGridDimensions() -> (maxColumn: Int, maxRow: Int, minColumn: Int, minRow: Int) {
    var maxX = 0
    var maxY = 0
    var minX = 1000
    var minY = 1000
    for coor in coordinates {
      if coor.x > maxX {
        maxX = coor.x
      }
      if coor.y > maxY {
        maxY = coor.y
      }
      if coor.x < minX {
        minX = coor.x
      }
      if coor.y < minY {
        minY = coor.y
      }
    }
    return (maxColumn: maxX, maxRow: maxY, minColumn: minX, minRow: minY)
  }
  
  public func fillGrid() {
    let dimensions = findGridDimensions()
    for xColumn in (dimensions.minColumn...dimensions.maxColumn) {
      for yRow in (dimensions.minRow...dimensions.maxRow) {
        var closestCoordinate = coordinates.first
        let currentLocation = (x: xColumn, y: yRow)
        var distance = closestCoordinate!.distanceFrom(coordinatePoint: currentLocation)
        for coor in coordinates {
          let coorDistance = coor.distanceFrom(coordinatePoint: currentLocation)
          if coorDistance < distance {
            closestCoordinate = coor
            distance = coorDistance
          } else if coorDistance == distance {
            closestCoordinate = nil
          }
        }
        if coordinateHash[xColumn] != nil {
          coordinateHash[xColumn]![yRow] = closestCoordinate
        } else {
          coordinateHash[xColumn] = [yRow: closestCoordinate]
        }
      }
    }
  }
  
  public func fillGridProblem2() {
    let dimensions = findGridDimensions()
    for xColumn in (dimensions.minColumn...dimensions.maxColumn) {
      for yRow in (dimensions.minRow...dimensions.maxRow) {
        let currentLocation = (x: xColumn, y: yRow)
        let totalDistance = coordinates.reduce(0, { (acc, coordinate) in return acc + coordinate.distanceFrom(coordinatePoint: currentLocation) })
        if distanceHash[xColumn] != nil {
          distanceHash[xColumn]![yRow] = totalDistance
        } else {
          distanceHash[xColumn] = [yRow: totalDistance]
        }
      }
    }
  }
  
  public func findInEligableIds() -> [Int] {
    var inEligableIds: [Int] = []
    let dimensions = findGridDimensions()
    for xColumn in (dimensions.minColumn...dimensions.maxColumn) {
      if xColumn == dimensions.maxColumn || xColumn == dimensions.minColumn {
        for yRow in (dimensions.minRow...dimensions.maxRow) {
          if let coordinate = coordinateHash[xColumn]?[yRow] {
            if let coordinate = coordinate {
              if !inEligableIds.contains(where: { $0 == coordinate.id }) {
                inEligableIds.append(coordinate.id)
              }
            }
          }
        }
      }
      if let firstRowCoordinate = coordinateHash[xColumn]?[dimensions.minRow] {
        if let firstRowCoordinate = firstRowCoordinate, !inEligableIds.contains(where: { $0 == firstRowCoordinate.id }) {
          inEligableIds.append(firstRowCoordinate.id)
        }
      }
      if let lastRowCoordinate = coordinateHash[xColumn]?[dimensions.maxRow] {
        if let lastRowCoordinate = lastRowCoordinate, !inEligableIds.contains(where: { $0 == lastRowCoordinate.id }) {
          inEligableIds.append(lastRowCoordinate.id)
        }
      }
    }
    
    return inEligableIds
  }
  
  public func findMaxArea() -> Int {
    var coordinateHashCount: [Int: Int] = [:]
    let inEligableIds = findInEligableIds()
    print("InligableIds: \(inEligableIds)")
    for (_, rowHash) in coordinateHash {
      for (_, coordinate) in rowHash {
        if let coordinate = coordinate, !inEligableIds.contains(where: { $0 == coordinate.id }) {
          if coordinateHashCount[coordinate.id] != nil {
            coordinateHashCount[coordinate.id]! += 1
          } else {
            coordinateHashCount[coordinate.id] = 1
          }
        }
      }
    }
    
    var maxArea = 0
    for (_, count) in coordinateHashCount {
      if count > maxArea {
        maxArea = count
      }
    }
    return maxArea
  }
  
  public func findAreaWithDitanceLessThan1000() -> Int {
    var area = 0
    for (_, rowHash) in distanceHash {
      for (_, distance) in rowHash {
        if distance < 10000 {
          area += 1
        }
      }
    }
    return area
  }
}
