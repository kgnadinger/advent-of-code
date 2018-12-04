import Foundation

public struct Guard {
  public let id: String
  public var awakeDates: [Date]
  public var asleepDates: [Date]
  
  public init(id: String) {
    self.id = id
    self.awakeDates = []
    self.asleepDates = []
  }
  
  public func findAsleepMinuteFreq() -> (minute: Int, count: Int?)? {
    if asleepDates.isEmpty {
      return nil
    }
    var minuteFreq: [Int: Int] = [:]
    var calendar = Calendar.current
    calendar.timeZone = TimeZone(abbreviation: "GMT+0:00")!
    for date in asleepDates {
      let minute = calendar.component(.minute, from: date)
      if minuteFreq[minute] == nil {
        minuteFreq[minute] = 1
      } else {
        minuteFreq[minute] = minuteFreq[minute]! + 1
      }
    }
    let mostFrequent = minuteFreq.keys.sorted(by: { (first, second) in
      minuteFreq[first]! > minuteFreq[second]!
    }).first!
    
    return (minute: mostFrequent, count: minuteFreq[mostFrequent])
  }
  
  public func findMostCommonAsleepMinute() -> Int {
    let minuteFreq = findAsleepMinuteFreq()
    if let minuteFreq = minuteFreq {
      return minuteFreq.minute
    } else {
      return 0
    }
  }
  
  public func findMostCommonAsleepMinuteFrequencyCount() -> Int {
    let minuteFreq = findAsleepMinuteFreq()
    if let minuteFreq = minuteFreq, let count = minuteFreq.count {
      return count
    } else {
      return 0
    }
  }
  
  public var mostFrequentMinuteCount: Int {
    get {
      let minuteFreq = findAsleepMinuteFreq()
      if let minuteFreq = minuteFreq, let count = minuteFreq.count {
        return count
      } else {
        return 0
      }
    }
  }
}
