import Foundation
import UIKit

let fileURL = Bundle.main.url(forResource: "input", withExtension: "txt")
var content = try String(contentsOf: fileURL!, encoding: String.Encoding.utf8)
var input = content.split(separator: "\n").map { String($0) }

let main = Main(input: input)

let graph = main.graph()

// Problem 1
print(graph.description)


// Problem 2
print(main.findSmallestArea())
