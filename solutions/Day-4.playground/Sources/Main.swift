import Foundation

public class Main {
  
  public var guardInputs: [GuardInput]
  public var guards: [Guard]
  let data: [String.SubSequence]
  
  public init(data: [String.SubSequence]) {
    self.data = data
    self.guardInputs = [GuardInput]()
    self.guards = [Guard]()
  }
  
  public func run() {
    let delimiters = CharacterSet.init(charactersIn: "[]")
    for input in data {
      let inputAsString = String(input)
      let stringArray = inputAsString.components(separatedBy: delimiters)
      let date = stringArray[1]
      let guardInformation = stringArray.last!
      let index = guardInformation.index(guardInformation.startIndex, offsetBy: 1)
      guardInputs.append(GuardInput(date: date, data: String(guardInformation[index...])))
    }
    sortGuardInputsAndUpdateId()
    createGuardList()
  }
  
  public func findGuardMostAsleep() -> Guard {
    let sortedGuardsBySleeping = guards.sorted(by: { firstGuard, secondGuard in
      return firstGuard.asleepDates.count > secondGuard.asleepDates.count
    })
    return sortedGuardsBySleeping.first!
  }
  
  public func findGuardWithMostFrequentMinuteAsleep() -> Guard {
    let sortedGuardsByMinute = guards.sorted(by: { (firstGuard, secondGuard) in
      return firstGuard.mostFrequentMinuteCount > secondGuard.mostFrequentMinuteCount
    })
    return sortedGuardsByMinute.first!
  }
  
  func sortGuardInputsAndUpdateId() {
    self.guardInputs = guardInputs.sorted()
    var currentGuardId = ""
    for (index, guardInput) in self.guardInputs.enumerated() {
      if let id = guardInput.guardId {
        currentGuardId = id
      }
      guardInputs[index].guardId = currentGuardId
    }
  }
  
  func getDateRange(fromDate date: Date, numberOfIntervals: Int) -> [Date] {
    var dates: [Date] = []
    for interval in (0...numberOfIntervals-1) {
      let timeInterval = TimeInterval(interval * 60)
      let newDate = date.addingTimeInterval(timeInterval)
      dates.append(newDate)
    }
    return dates
  }
  
  func createGuardList() {
    var firstDate: Date = Date()
    for (index, guardInput) in guardInputs.enumerated() {
      if index == 0 {
        firstDate = guardInput.guardDate
      }
      switch (guardInput.guardAction) {
      case .BeginShift:
        guards.append(Guard(id: guardInput.id))
      case .FallsAsleep:
        let nextDate = guardInputs[index + 1].guardDate
        let currentDate = guardInput.guardDate
        let timeInterval = Int(nextDate.timeIntervalSince(firstDate) - currentDate.timeIntervalSince(firstDate)) / 60
        let dateRange = getDateRange(fromDate: currentDate, numberOfIntervals: timeInterval)
        if let index = guards.firstIndex(where: { $0.id == guardInput.id }) {
          for date in dateRange {
            guards[index].asleepDates.append(date)
          }
        } else {
          var guardObject = Guard(id: guardInput.id)
          guardObject.asleepDates = dateRange
          guards.append(guardObject)
        }
      case .WakesUp:
        break
      }
    }
  }
}
