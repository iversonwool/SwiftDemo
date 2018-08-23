//
//  main.swift
//  05.ControlFlow
//
//  Created by LeeHow on 2018/8/20.
//  Copyright © 2018 LeeHow. All rights reserved.
//

import Foundation

print("Hello, World!")

for index in 1...6 { // [1, 6]
    print(index, separator: " ", terminator: "\n")
}



for character in "Hello" {
    print(character)
}

// C-style for statement has been removed in Swift 3

//for var index = 0; index < 5; index += 1 {
//    print(index)
//}

var index = 0

while index < 5 {
    print(index)
    index += 1
//    p
}

//do {
//    index += 1
//} while index < 20



repeat {
    print(index)
    index += 1
} while index < 20

let count = 1_000_000
let countedThings = "stars in the Milky Way."
var naturalCount: String
switch count {
case 0:
    naturalCount = "no"
case 1...3:
    naturalCount = "a few"
case 4...9:
    naturalCount = "several"
case 10...99:
    naturalCount = "tens of"
case 100...999:
    naturalCount = "hundreds of"
case 1000...9999:
    naturalCount = "thousands of"
default:
    naturalCount = "millions and millions of"
}
print("There are \(naturalCount) \(countedThings)")

// value bindings

var anotherPoint = (2, 0)
//let  = <#value#>
anotherPoint = (3, 5)
switch anotherPoint {
case (let x, 0):
    print("on the x-axis with a x value of \(x)")
case (0, let y):
    print("on the y-axis with a x value of \(y)")
case (let x, let y):
    print("the point is (\(x), \(y))")
//default:
//    print("just a point")
}

//*****************************************************//
// 如果最后一个case的值能匹配所有的情况 那么不需要default 分支 //
//*****************************************************//



// where 的进一步判断

let linePoint = (1, -1)
switch linePoint {
case (let x, let y) where x == y:
    print("line x == y")
case (let x, let y) where x == -y:
    print("line x == y")
case (let x, let y):
    print("not line point (\(x), \(y))")
}


if #available(iOS 10, macOS 10.12, *) {
    print("available")
} else {
    print("not available")
}

//if #available(iOS 10, *) {
//
//}


