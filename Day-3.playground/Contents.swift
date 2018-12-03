import Foundation

let fileURL = Bundle.main.url(forResource: "input", withExtension: "txt")
let content = try String(contentsOf: fileURL!, encoding: String.Encoding.utf8)

let splitInput = content.split(separator: "\n")

let fabric = Fabric()
let main = Main(fabric: fabric, input: splitInput)
let result = main.run()
print(result)

/*
 I found out that playground has some performance limitations today. Any large computation's will slow to a crawl if dont in the main playground file.
 
 Instead, as I have done here, I've organized the computation into source files which are compiled and ran outside the playground environement. 
 
*/



