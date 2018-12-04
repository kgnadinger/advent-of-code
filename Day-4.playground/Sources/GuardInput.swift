import Foundation

public struct GuardInput: CustomStringConvertible, Comparable {
  let date: Date
  let data: String
  var guardId: String?
  public let guardAction: GuardAction
  
  public var id: String {
    get {
      return guardId ?? ""
    }
  }
  
  public var guardDate: Date {
    get {
      return date
    }
  }
  
  public enum GuardAction: String {
    case BeginShift = "begins shift"
    case WakesUp = "wakes up"
    case FallsAsleep = "falls asleep"
  }
  
  public init(date: String, data: String) {
    func covertToDate(_ stringInput: String) -> Date {
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
      dateFormatter.timeZone = TimeZone(abbreviation: "GMT+0:00")
      let date = dateFormatter.date(from: stringInput)!
      return date
    }
    
    func parseGuard(data guardData: String) -> (guardId: String?, guardAction: GuardAction) {
      var guardIdAsString = ""
      if let hashIndex = guardData.firstIndex(of: "#") {
        for char in guardData[hashIndex...] {
          if let _ = Int(String(char)) {
            guardIdAsString += String(char)
          }
        }
      }
      let guardActionArray = guardData.split(separator: " ")
      let guardActionString = "\(guardActionArray[guardActionArray.count - 2]) \(guardActionArray.last!)"
      let guardAction = GuardAction(rawValue: guardActionString)!
      return (guardId: guardIdAsString.isEmpty ? nil : guardIdAsString, guardAction: guardAction)
    }
    
    
    self.date = covertToDate(String(date))
    self.data = String(data)
    self.guardId = parseGuard(data: data).guardId
    self.guardAction = parseGuard(data: data).guardAction
  }
  
  public mutating func update(guardId id: String) {
    self.guardId = id
  }
  
  public var description: String {
    return "Date: \(date), Guard Id: \(guardId), Guard Action: \(guardAction.rawValue)"
  }
  
  public static func <(left: GuardInput, right: GuardInput) -> Bool {
    return left.date < right.date
  }
  
  public static func ==(left: GuardInput, right: GuardInput) -> Bool {
    return (left.guardId == right.guardId) && (left.date == right.date)
  }
}
