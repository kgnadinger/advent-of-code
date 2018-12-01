import Foundation

let fileURL = Bundle.main.url(forResource: "advent_day_1_input", withExtension: "txt")
let content = try String(contentsOf: fileURL!, encoding: String.Encoding.utf8)


// Problem 1
let splitInput = content.split(separator: "\n")

func convertToInt (object: String.SubSequence) -> Int {
  return Int(String(object))!
}

let answer = splitInput.map(convertToInt).reduce(0, +)

// Problem 2

func findFirstFrequencyRepeat(inputs: [Int], frequencyDict: Dictionary<Int, Int>, currentTotal: Int) -> Int {
  var frequencies = frequencyDict
  var runningTotal = currentTotal
  for input in inputs {
    runningTotal += input
    if let currentFreq = frequencies[runningTotal] {
      frequencies[runningTotal] = currentFreq + 1
    } else {
      frequencies[runningTotal] = 1
    }
    if frequencies[runningTotal] == 2 {
      return runningTotal
    }
  }
  return findFirstFrequencyRepeat(inputs: inputs, frequencyDict: frequencies, currentTotal: runningTotal)
}

let inputs = splitInput.map(convertToInt)
var frequencies: Dictionary<Int, Int> = [:]
frequencies[0] = 1
var runningTotal = 0

let solution = findFirstFrequencyRepeat(inputs: inputs, frequencyDict: frequencies, currentTotal: runningTotal)

print(solution)
