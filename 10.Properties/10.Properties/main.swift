//
//  main.swift
//  10.Properties
//
//  Created by LeeHow on 2018/8/21.
//  Copyright © 2018 LeeHow. All rights reserved.
//

import Foundation

print("Hello, World!")



struct FixedLengthRange {
    var firstValue: Int
    let length: Int

}



var rangeOfThreeItems = FixedLengthRange(firstValue: 0, length: 3)


print(rangeOfThreeItems.firstValue, rangeOfThreeItems.length)


rangeOfThreeItems.firstValue = 6
//rangeOfThreeItems.length = 4 // constant


class DataImporter {
    var fileName = "data.txt"
    
}





class DataManager {
    lazy var importer = DataImporter()
    var data = [String]()
    
}

let manager = DataManager()


print(manager.importer.fileName)


//注意
//
//如果一个被标记为 lazy 的属性在没有初始化时就同时被多个线程访问，则无法保证该属性只会被初始化一次。




// 没有实例变量


struct Point {
    var x = 0.0, y = 0.0
    
}



struct Size {
    var width = 0.0, height = 0.0
    
}

struct Rect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            return Point(x: origin.x + size.width / 2,
                         y: origin.y + size.height / 2)
        }
//        set(newCenter) {
//            origin.x = newCenter.x - size.width / 2
//            origin.y = newCenter.y - size.height / 2
//        }
        
        set {
            origin.x = newValue.x - size.width / 2
            origin.y = newValue.y - size.height / 2
        }
    }
}

var square = Rect(origin: Point(), size: Size(width: 10.0, height: 10.0))

let initialCenter = square.center

print(initialCenter)

square.center = Point(x: 30.0, y: 40.0)

print(square.origin)


struct Cuboid {
    var width = 0.0, height = 0.0, depth = 0.0
    
    var volume: Double {
        return width * height * depth
    }
    
}

let cuboid = Cuboid(width: 3.0, height: 4.0, depth: 5.0)
print(cuboid.volume)

// readonly
//cuboid.volume = 70

class StepCounter {
    var totalSteps: Int = 0 {
        willSet {
            print("About to set totalSteps to \(newValue)")
        }
        didSet {
            if totalSteps > oldValue {
                print("Add \(totalSteps - oldValue) steps")
            }
        }
    }
    
}

let stepCounter = StepCounter()
stepCounter.totalSteps = 200

stepCounter.totalSteps = 360

//struct Cuboid {
//    var width = 0.0, height = 0.0, depth = 0.0
//    var volume: Double {
//        get {
//            return depth * height * width
//        }
//        //        willSet {
//        //
//        //        }
//        set {
//            print(newValue)
//        }
//    }
//}

struct SomeStructure {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 1
    }
}

enum SomeEnumeration {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 1
    }
    case case1
}

class SomeClass {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 1
    }
}

print(SomeStructure.storedTypeProperty)

SomeStructure.storedTypeProperty = "Another Value."
print(SomeStructure.storedTypeProperty)

print(SomeEnumeration.computedTypeProperty)

print(SomeClass.computedTypeProperty)

struct AudioChannel {
    static let thresholdLevel = 10
    static var maxInputLevelForAllChannels = 0
    var currentLevel: Int = 0 {
        didSet {
            if currentLevel > AudioChannel.thresholdLevel {
                currentLevel = AudioChannel.thresholdLevel
            }
            if currentLevel > AudioChannel.maxInputLevelForAllChannels {
                AudioChannel.maxInputLevelForAllChannels = currentLevel
            }
        }
    }
    
}
var leftChannel = AudioChannel()
var rightChannle = AudioChannel()

leftChannel.currentLevel = 7
print(leftChannel.currentLevel)
print(AudioChannel.maxInputLevelForAllChannels)
rightChannle.currentLevel = 11
print(rightChannle.currentLevel)
print(AudioChannel.maxInputLevelForAllChannels)





