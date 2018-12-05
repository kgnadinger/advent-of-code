import Foundation

public class Polymer {
  let inputString: String
  
  
  public init(inputString: String) {
    self.inputString = inputString
  }
  
  
  public func findOptimalUnitTypeAndReturnLength() -> Int {
    print("Starting Test")
    let unitTypesString = "abcdefghijklmnopqrstuvwxyz"
    let unitTypes = Array(unitTypesString).map { String($0) }
    var lowestCount = 1000 * 1000
    for unitType in unitTypes {
      let count = testUnitType(letter: unitType)
      if count < lowestCount {
        lowestCount = count
      }
    }
    return lowestCount
  }
  
  
  public func testUnitType(letter: String) -> Int {
    print("Testing Letter: \(letter)")
    let inputStringArray = Array(inputString).map { String($0) }
    var sanatizedString = ""
    for char in inputStringArray {
      if !((char == letter) || (char == letter.uppercased())) {
        sanatizedString += char
      }
    }
    let collapsedString = destroyPairs(inString: sanatizedString)
    print("Letter: \(letter), Count: \(collapsedString.count)")
    return collapsedString.count
  }
  
  
  public func destroyPairs(inString inputString: String) -> String {
    var foundPairsToDestroy = false
    var inputStringArray = Array(inputString).map({ String($0) })
    var returnStringArray: [String] = []
    var index = 0
    while (index <= (inputStringArray.count - 1)) {
      let char = inputStringArray[index]
      if index == inputStringArray.count - 1 {
        returnStringArray.append(char)
        index += 1
      } else {
        let nextChar = inputStringArray[index + 1]
        if ((char.lowercased() == nextChar.lowercased()) && (char != nextChar)) {
          foundPairsToDestroy = true
          index += 2
        } else {
          returnStringArray.append(char)
          index += 1
        }
      }
    }
    if foundPairsToDestroy {
      return destroyPairs(inString: returnStringArray.joined())
    } else {
      return returnStringArray.joined()
    }
  }
}
