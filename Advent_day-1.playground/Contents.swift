import Foundation

let fileURL = Bundle.main.url(forResource: "advent_day_1_input", withExtension: "txt")
let content = try String(contentsOf: fileURL!, encoding: String.Encoding.utf8)

let splitInput = content.split(separator: "\n")

func convertToInt (object: String.SubSequence) -> Int {
  return Int(String(object))!
}

let answer = splitInput.map(convertToInt).reduce(0, +)

print(answer)

