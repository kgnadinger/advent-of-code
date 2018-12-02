import Foundation

let fileURL = Bundle.main.url(forResource: "input", withExtension: "txt")
let content = try String(contentsOf: fileURL!, encoding: String.Encoding.utf8)

let splitInput = content.split(separator: "\n")

// Problem 1

func foundDuplicateCharactersCount(inString input: String.SubSequence, forFrequency frequency: Int) -> Bool {
  var charFreqList: [Character: Int] = [:]
  for char in input {
    if let previousCharCount = charFreqList[char] {
      charFreqList[char] = previousCharCount + 1
    } else {
      charFreqList[char] = 1
    }
  }
  return charFreqList.filter({ (key, value) in value == frequency }).count > 0
}

var twoCharactersFound = 0
var threeCharactersfound = 0

for id in splitInput {
  twoCharactersFound += foundDuplicateCharactersCount(inString: id, forFrequency: 2) ? 1 : 0
  threeCharactersfound += foundDuplicateCharactersCount(inString: id, forFrequency: 3) ? 1 : 0
}

// Solution
twoCharactersFound * threeCharactersfound

// Problem 2
func checkIfIdsAreSimilar(forId firstId: String.SubSequence, toId secondId: String.SubSequence) -> Bool {
  if firstId == secondId {
    return false
  }
  var charDifferenceCount = 0
  for (charIndex, char) in firstId.enumerated() {
    let indexObject = secondId.index(secondId.startIndex, offsetBy: charIndex)
    charDifferenceCount += char != secondId[indexObject] ? 1 : 0
  }
  return charDifferenceCount == 1
}

func checkForSimiliarId(_ input: String.SubSequence, inInputs inputs: [String.SubSequence]) -> (firstId: String.SubSequence, secondId: String.SubSequence)? {
  for localInput in inputs {
    if checkIfIdsAreSimilar(forId: input, toId: localInput) {
      return (input, localInput)
    }
  }
  return nil
}

func removeIncorrectCharacters(forId firstId: String.SubSequence, andId secondId: String.SubSequence) -> String.SubSequence? {
  for (charIndex, char) in firstId.enumerated() {
    let startIndexObject = secondId.index(secondId.startIndex, offsetBy: charIndex)
    if char != secondId[startIndexObject] {
      let endIndexObject = secondId.index(secondId.startIndex, offsetBy: charIndex+1)
      let firstHalf = secondId[..<startIndexObject]
      let secondHalf = secondId[endIndexObject...]
      print("ID: \(secondId), charToRemove: \(char), firstHalf: \(firstHalf), secondHalf: \(secondHalf)")
      return firstHalf + secondHalf
    }
  }
  return nil
}

func findTheCorrectId(inInputs inputs: [String.SubSequence]) -> String.SubSequence? {
  for id in inputs {
    if let inputs = checkForSimiliarId(id, inInputs: splitInput) {
      return removeIncorrectCharacters(forId: inputs.firstId, andId: inputs.secondId)
    }
  }
  return nil
}

// Solution
findTheCorrectId(inInputs: splitInput)


