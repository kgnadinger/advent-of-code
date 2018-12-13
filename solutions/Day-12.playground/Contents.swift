import UIKit
let fileURL = Bundle.main.url(forResource: "input", withExtension: "txt")
var content = try String(contentsOf: fileURL!, encoding: String.Encoding.utf8)
let input = content.split(separator: "\n").map { String($0) }
let initialState = input.first!
let instructionInput = input[1...]


var plants: [Plant] = []
var instructions: [String: String] = [:]

for num in (-3...initialState.count + 2) {
  if num < 0 {
    let newPlant = Plant(".")
    plants.append(newPlant)
  } else if num == 0 {
    let index = initialState.index(initialState.startIndex, offsetBy: num)
    let char = String(initialState[index])
    let newPlant = Plant(char)
    newPlant.original = true
    plants.append(newPlant)
  } else if (num >= 0 && num < initialState.count) {
    let index = initialState.index(initialState.startIndex, offsetBy: num)
    let char = String(initialState[index])
    let newPlant = Plant(char)
    plants.append(newPlant)
  } else {
    let newPlant = Plant(".")
    plants.append(newPlant)
  }
}

for instruction in instructionInput {
  let stateEndIndex = instruction.index(instruction.startIndex, offsetBy: 4)
  let state = String(instruction[instruction.startIndex...stateEndIndex])
  let resultEndIndex = instruction.index(instruction.endIndex, offsetBy: -1)
  let result = String(instruction[resultEndIndex])
  
  instructions[state] = result
}

// Problem 1
let main1 = Main(plants: plants, instructions: instructions)
let solution1 = main1.run(iterations: 20)




// Start of Problem 2
// Turns out the difference between iterations eventually repeats, lets just find the solution up to that repeating and then calculate the rest

var solutions: [Int] = []
var difference = 0
for num in (1...200) {
  let main = Main(plants: plants, instructions: instructions)
  let solution = main.run(iterations: num)
  if num > 1 {
    difference = solution - solutions.last!
  }
  solutions.append(solution)
}

var haveNotFoundDifference = true
var i = 1
var whileBreakSolution = 0
var lastSolution = 0
while(haveNotFoundDifference) {
  let main = Main(plants: plants, instructions: instructions)
  let solution = main.run(iterations: i)
  if i > 1 {
    let localDiff = solution - lastSolution
    if localDiff == difference {
      whileBreakSolution = solution
      haveNotFoundDifference = false
    } else {
      lastSolution = solution
    }
  }
  i += 1
}
let solutionToAdd = (50000000000 - i + 1) * difference

// Problem 2
let solution = whileBreakSolution + solutionToAdd
print(solution)
