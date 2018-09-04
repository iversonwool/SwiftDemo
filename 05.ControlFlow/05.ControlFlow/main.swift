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

let xxx = UInt8("12")
print("xxx is \(xxx!)")

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


//提前退出
//guard
//条件必须为真时，以执行 guard 语句后的代码。
//不同于 if 语句，一个 guard 语句总是有一个 else 从句，如果条件不为真则执行 else 从句中的代码。

//避免了厄运金字塔 Pyramid of Doom

//http://blog.scottlogic.com/2014/12/08/swift-optional-pyramids-of-doom.html
//https://nshipster.cn/guard-and-defer/

func greet(person: [String: String]) {
    guard let name = person["name"] else { return }
    print("Hello \(name)!")
    guard let location = person["location"] else {
        print("I hope the weather is nice near you.")
        return
    }
    print("I hope the weather is nice in \(location)!")
}

greet(person: ["name": "John"])
greet(person: ["name": "Jane", "location": "Cupertino"])



enum ConversionError: Error {
    case InvalidFormat, OutOfBounds, Unknown
}

extension UInt8 {
    init(fromString string: String) throws {
        guard string == "Hello" else {
            throw ConversionError.InvalidFormat
        }
        guard UInt8(string)! == UInt8.max else {
            throw ConversionError.OutOfBounds
        }
        guard let value = UInt(string) else { throw ConversionError.Unknown }
        self.init(value)
    }
}

//try {
//    if let someInt = UInt8(fromString: "Hello") {
//        print(someInt)
//    }
//}

if #available(iOS 10, macOS 10.12, *) {
    print("available")
} else {
    print("not available")
}

//if #available(iOS 10, *) {
//
//}


