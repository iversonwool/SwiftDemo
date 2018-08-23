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
            print("About ")
        }
    }
    
}




