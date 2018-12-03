import Foundation

let fileURL = Bundle.main.url(forResource: "input", withExtension: "txt")
let content = try String(contentsOf: fileURL!, encoding: String.Encoding.utf8)

let splitInput = content.split(separator: "\n")

let fabric = Fabric()
let main = Main(fabric: fabric, input: splitInput)
let result = main.run()
print(result)





