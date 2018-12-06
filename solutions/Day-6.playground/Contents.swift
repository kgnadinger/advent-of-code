import Foundation

let fileURL = Bundle.main.url(forResource: "input", withExtension: "txt")
let content = try String(contentsOf: fileURL!, encoding: String.Encoding.utf8)

let coordinates =
  content
    .split(separator: "\n")
    .map({ String($0) })
    .map({ $0.split(separator: ",") })
    .enumerated()
    .map({ (index, coordinateArray) -> Coordinate in
      let first = Int(String(coordinateArray.first!))!
      let secondString = String(String(coordinateArray.last!).split(separator: " ").last!)
      let second = Int(secondString)!
      return Coordinate(id: index, x: first, y: second)
    })

let main = Main(coordinates: coordinates)

main.fillGrid()
let solution = main.findMaxArea()
print("Max Area: \(solution)")

main.fillGridProblem2()
let solution2 = main.findAreaWithDitanceLessThan1000()
print("Area: \(solution2)")
