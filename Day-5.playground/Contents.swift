import Foundation

let fileURL = Bundle.main.url(forResource: "input", withExtension: "txt")
let content = try String(contentsOf: fileURL!, encoding: String.Encoding.utf8)

// Last char in content is '\n', let's gid rid of that
var contentArray = Array(content).map { String($0) }
contentArray.popLast()

let stringInput = contentArray.joined()
let polymer = Polymer(inputString: stringInput)

// Problem 1
let solution = polymer.destroyPairs(inString: stringInput)
print(solution.count)


// Problem 2
let solution2 = polymer.findOptimalUnitTypeAndReturnLength()
print(solution2)
