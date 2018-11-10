//
//  main.swift
//  20.Extensions
//
//  Created by LeeHow on 2018/8/24.
//  Copyright © 2018 LeeHow. All rights reserved.
//

import Foundation

print("Hello, World!")


//MARK: - 扩展语法
//注意

//扩展可以为一个类型添加新的功能，但是不能重写已有的功能。

//extension SomeType {
//    // 为 SomeType 添加的新功能写到这里
//}
//
//注意
//
//如果你通过扩展为一个已有类型添加新功能，那么新功能对该类型的所有已有实例都是可用的，即使它们是在这个扩展定义之前创建的。


//MARK: - 计算型属性
extension Double {
    var km: Double { return self * 1_000.0 }
    var m: Double { return self }
    var cm: Double { return self / 100.0 }
    var mm: Double { return self / 1_000.0 }
    var ft: Double { return self / 3.28084 }
}

let oneInch = 25.4.mm
print("oneInch is \(oneInch) meters")

let oneMeter = 1.0.m

//
//注意
//////////////////////////////////////////////////////////////////////////
//扩展可以添加新的计算型属性，但是不可以添加存储型属性，也不可以为已有属性添加属性观察器。
//////////////////////////////////////////////////////////////////////////

//MARK: - 构造器
struct Size {
    var width = 0.0, height = 0.0
}
struct Point {
    var x = 0.0, y = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
}


let defaultRect = Rect()

let memberwiseRect = Rect(origin: Point(x: 2.0, y: 2.0), size: Size(width: 5.0, height: 5.0))

extension Rect {
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}



let centerRect = Rect(center: Point(x: 4.0, y: 4.0),
                        size: Size(width: 3.0, height: 3.0))
//
//
//注意
//
//如果你使用扩展提供了一个新的构造器，你依旧有责任确保构造过程能够让实例完全初始化。



//MARK: - 方法

extension Int {
    func repetitions(task: () -> Void) {
        for _ in 0..<self {
            task()
        }
    }
}

/////尾随闭包调用可以省略括号
3.repetitions {
    print("Hello!")
}


//MARK: - 可变实例方法
extension Int {
    mutating func square() {
        self = self * self
    }
}
//定义someInt 为var 类型
var someInt = 3
someInt.square()

print(someInt)

//MARK: - 下标 subscript
extension Int {
    subscript(digitIndex: Int) -> Int {
        var decimalBase = 1
        for _ in 0..<digitIndex {
            decimalBase *= 10
        }
        return (self / decimalBase) % 10
    }
}

print(328_473_284[3])




//MARK: - 嵌套类型

extension Int {
    enum Kind {
        case negative, zero, positive
    }
    var kind: Kind {
        switch self {
        case 0:
            return .zero
        case let x where x > 0:
            return .positive
        default:
            return .negative
        }
    }
    
}

func printIntegerKinds(_ numbers: [Int]) {
    for number in numbers {
        switch number.kind {
        case .negative:
            print("- ", terminator: "")
        case .zero:
            print("0 ", terminator: "")
        case .positive:
            print("+ ", terminator: "")
        }

    }
    print("")
}


printIntegerKinds([3, 19, -27, 0, -6, 0, 7])





