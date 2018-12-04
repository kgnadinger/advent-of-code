import Foundation

let fileURL = Bundle.main.url(forResource: "input", withExtension: "txt")
let content = try String(contentsOf: fileURL!, encoding: String.Encoding.utf8)

let splitInput = content.split(separator: "\n")

let main = Main(data: splitInput)
main.run()

// Problem 1
let solution = main.findGuardMostAsleep()

print("Guard Who Sleeps The Most: \(solution.id), amount: \(solution.asleepDates.count), mostCommonMinute: \(solution.findMostCommonAsleepMinute())")
print(Int(solution.id)! * solution.findMostCommonAsleepMinute())



// Problem 2
let solution2 = main.findGuardWithMostFrequentMinuteAsleep()
print("Guard Who Sleeps The Most: \(solution2.id), amount: \(solution2.asleepDates.count), mostCommonMinute: \(solution2.findMostCommonAsleepMinute())")
print(Int(solution2.id)! * solution2.findMostCommonAsleepMinute())
