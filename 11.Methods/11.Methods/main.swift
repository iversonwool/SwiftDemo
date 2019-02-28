//
//  main.swift
//  11.Methods
//
//  Created by LeeHow on 2018/8/22.
//  Copyright © 2018 LeeHow. All rights reserved.
//

import Foundation


print("Hello, World!")



class Counter {
    var count = 0
    func increment() {
        count += 1
    }
    func increment(by amount: Int) {
        count += amount
    }
    func reset() {
        count = 0
    }
    
}

let counter = Counter()

counter.increment()

counter.increment(by: 5)

counter.reset()

//
//实际上，你不必在你的代码里面经常写 self。
//不论何时，只要在一个方法中使用一个已知的属性或者方法名称，如果你没有明确地写 self，Swift 假定你是指当前实例的属性或者方法。
//这种假定在上面的 Counter 中已经示范了：Counter 中的三个实例方法中都使用的是 count（而不是 self.count）。

//参数名称 和 属性名称

struct Point {
    var x = 0.0, y = 0.0
    func isToTheRightOfX(_ x: Double) -> Bool {
        return self.x > x
    }
    mutating func moveByX(_ deltaX: Double, _ deltaY: Double) {
        x += deltaX
        y += deltaY
    }
    
}
let somePoint = Point(x: 4.0, y: 5.0)
if somePoint.isToTheRightOfX(1.0) {
    print("this point is to the right of the line where x == 1.0")
}

//结构体和枚举是值类型。默认情况下，值类型的属性不能在它的实例方法中被修改。




var aPoint = Point(x: 1.0, y: 1.0)
aPoint.moveByX(2.0, 3.0)


//Cannot use mutating member on immutable value: 'somePoint' is a 'let' constant
//somePoint.moveByX(0.9, 9.0)


print("the point is now at (\(aPoint.x), \(aPoint.y))")

//warning
//注意，不能在结构体类型的常量（a constant of structure type）上调用可变方法，因为其属性不能被改变，即使属性是变量属性






enum TriStateSwitch {
    case Off, Low, High
    mutating func next() {
        switch self {
        case .Off:
            self = .Low
        case .Low:
            self = .High
        case .High:
            self = .Off
        }
    }
}




class ClassType {
    //用class 修饰的类型方法 可以被重写
    class func someTypeMethod() {
        print("call someTypeMethod")
    }
    
    
    //Cannot override static method
    static func typeMethod() {
        print("XXX")
    }
}

ClassType.someTypeMethod()

//重写父类的类型方法
class SubClassType: ClassType {
    override class func someTypeMethod() {
        //
    }
    
//    override static func typeMethod() {
//        print("XXX-XXX")
//    }
}


struct LevelTracker {
    static var highestUnlockedLevel = 1
    var currentLevel = 1
    static func unlock(_ level: Int) {
        if level > highestUnlockedLevel {
            highestUnlockedLevel = level
        }
    }
    static func isUnlocked(_ level: Int) -> Bool {
        return level <= highestUnlockedLevel
    }
    @discardableResult
    mutating func advance(to level: Int) -> Bool {
        if LevelTracker.isUnlocked(level) {
            currentLevel = level
            return true
        } else {
            return false
        }
    }
    
}

class Player {
    var tracker = LevelTracker()
    let playerName: String
    func complete(level: Int) {
        LevelTracker.unlock(level + 1)
        tracker.advance(to: level + 1)
    }
    init(name: String) {
        playerName = name
    }
    
}

var player = Player(name: "Beto")
player.complete(level: 6)
if player.tracker.advance(to: 6) {
    print("player is now on level 6")
} else {
    print("level 6 has not yet been unlocked")
}





