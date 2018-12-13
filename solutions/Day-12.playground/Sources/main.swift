import Foundation

public class Main {
  var plants: [Plant] = []
  var instructions: [String: String] = [:]
  
  public init(plants: [Plant], instructions: [String: String]) {
    self.plants = plants
    self.instructions = instructions
  }
  
  public func run(iterations: Int) -> Int {
    for num in (1...iterations) {
      var nextGenerationOfPlants: [Plant] = []
      for (index, plant) in plants.enumerated() {
        let plantState = getState(forPlant: plant, index: index)
        let result = instructions[plantState]
        //    print("Index: \(index), Count: \(plants.count), State: \(plantState), Result: \(result == nil ? "." : result!)")
        if let generationResult = result {
          let nextPlant = Plant(generationResult)
          nextPlant.original = plant.original
          if index == 0 && nextPlant.hasPlant == .hasPlant {
            nextGenerationOfPlants.append(Plant("."))
          }
          nextGenerationOfPlants.append(nextPlant)
          if index == plants.count - 1 && nextPlant.hasPlant == .hasPlant {
            nextGenerationOfPlants.append(Plant("."))
          }
        } else {
          let nextPlant = Plant(".")
          nextPlant.original = plant.original
          nextGenerationOfPlants.append(nextPlant)
        }
      }
      plants = nextGenerationOfPlants
    }
    
    let indexOfOriginal = plants.firstIndex(where: { $0.original })!
    var solution = 0
    for (index, plant) in plants.enumerated() {
      solution += plant.hasPlant == .hasPlant ? (index - indexOfOriginal) : 0
    }
    return solution
  }
  
  
  func getState(forPlant plant: Plant, index: Int) -> String {
    var state = ""
    if index == 0 {
      state += ".."
      state += plant.hasPlant.rawValue
    } else if index == 1 {
      state += "."
      state += plants[0].hasPlant.rawValue
      state += plant.hasPlant.rawValue
    } else {
      state += plants[index - 2].hasPlant.rawValue
      state += plants[index - 1].hasPlant.rawValue
      state += plant.hasPlant.rawValue
    }
    
    if index <= plants.count - 3 {
      state += plants[index + 1].hasPlant.rawValue
      state += plants[index + 2].hasPlant.rawValue
    } else if index == plants.count - 2 {
      state += plants[index + 1].hasPlant.rawValue
      state += "."
    } else if index == plants.count - 1 {
      state += ".."
    }
    return state
  }
}
