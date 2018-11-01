//
//  main.swift
//  10.Properties
//
//  Created by LeeHow on 2018/8/21.
//  Copyright © 2018 LeeHow. All rights reserved.
//

import Foundation

print("Hello, World!")


//MARK: - 属性
//注意点
//计算属性可以用于类、结构体和枚举，
//存储属性只能用于类和结构体。

//实例属性
//类型属性

//常量结构体

//MARK: - 存储属性
struct FixedLengthRange {
    var firstValue: Int
    let length: Int

}



var rangeOfThreeItems = FixedLengthRange(firstValue: 0, length: 3)


print(rangeOfThreeItems.firstValue, rangeOfThreeItems.length)


rangeOfThreeItems.firstValue = 6
//rangeOfThreeItems.length = 4 // constant //该属性为常量

//MARK: - 常量结构体的存储属性
let rangeOfFourItems = FixedLengthRange(firstValue: 3, length: 4);
//rangeOfFourItems.firstValue = 6 //常量结构体 任何属性都不允许修改
//这种行为是由于结构体（struct）属于值类型。
//当值类型的实例被声明为常量的时候，它的所有属性也就成了常量
//属于引用类型的类（class）则不一样。
//把一个引用类型的实例赋给一个常量后，仍然可以修改该实例的变量属性。



//MARK: - 延迟存储属性
//注意
//
//必须将延迟存储属性声明成变量（使用 var 关键字），
//因为属性的初始值可能在实例构造完成之后才会得到。
//    而常量属性在构造过程完成之前必须要有初始值，
//因此无法声明成延迟属性。

class DataImporter {
    /*
     DataImporter 是一个负责将外部文件中的数据导入的类。
     这个类的初始化会消耗不少时间。
     */
    var fileName = "data.txt"
    // 这里会提供数据导入功能
}





class DataManager {
    lazy var importer = DataImporter()
    var data = [String]()
    // 这里会提供数据管理功能
}

let manager = DataManager()


print(manager.importer.fileName)


//注意
//
//如果一个被标记为 lazy 的属性在没有初始化时就同时被多个线程访问，则无法保证该属性只会被初始化一次。



//MARK: - 存储属性和实例变量
// 没有实例变量

//MARK: - 计算属性
//除存储属性外，类、结构体和枚举可以定义计算属性。
//计算属性不直接存储值，而是提供一个 getter 和一个可选的 setter，来间接获取和设置其他属性或变量的值。
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
        //MARK: - 简化setter声明
        set {
            origin.x = newValue.x - size.width / 2
            origin.y = newValue.y - size.height / 2
        }
    }
}


//MARK: - 只读计算属性
//注意
//
//必须使用 var 关键字定义计算属性，包括只读计算属性，因为它们的值不是固定的。
//let 关键字只用来声明常量属性，表示初始化后再也无法修改的值。

var square = Rect(origin: Point(), size: Size(width: 10.0, height: 10.0))

let initialCenter = square.center

print(initialCenter)

square.center = Point(x: 30.0, y: 40.0)

print(square.origin)


struct Cuboid {
    var width = 0.0, height = 0.0, depth = 0.0
//    只读计算属性的声明可以去掉 get 关键字和花括号：
    var volume: Double {
        return width * height * depth
    }
    
}

let cuboid = Cuboid(width: 3.0, height: 4.0, depth: 5.0)
print(cuboid.volume)

// readonly
//cuboid.volume = 70

//MARK: - 属性观察器
//你可以为除了延迟存储属性之外的其他存储属性添加属性观察器，
//也可以通过重写属性的方式为继承的属性（包括存储属性和计算属性）添加属性观察器。
//你不必为非重写的计算属性添加属性观察器，因为可以通过它的 setter 直接监控和响应值的变化。
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




//let stepCounter = StepCounter()
//stepCounter.totalSteps = 200
//
//stepCounter.totalSteps = 360

//注意
//
//父类的属性在子类的构造器中被赋值时，它在父类中的 willSet 和 didSet 观察器会被调用，随后才会调用子类的观察器。
//在父类初始化方法调用之前，子类给属性赋值时，观察器不会被调用。


class SubStepCounter: StepCounter {
    //
//    override var totalSteps: Int {
//        willSet {
//            print("About to set totalSteps to \(newValue)")
//        }
//        didSet {
//            if totalSteps > oldValue {
//                print("Add \(totalSteps - oldValue) steps")
//            }
//        }
//    }
//    init(totalSteps: Int) {
//        super.init()
//        self.totalSteps = totalSteps
//    }
}

let subStepCounter = SubStepCounter()
//let subStepCounter = SubStepCounter(totalSteps: 300)


//subStepCounter.totalSteps = 300


//MARK: - 全局变量和局部变量

//计算属性和属性观察器所描述的功能也可以用于全局变量和局部变量。
//全局变量是在函数、方法、闭包或任何类型之外定义的变量。
//局部变量是在函数、方法或闭包内部定义的变量。

//计算属性和属性观察器所描述的功能也可以用于全局变量和局部变量。
//全局变量是在函数、方法、闭包或任何类型之外定义的变量。
//局部变量是在函数、方法或闭包内部定义的变量。



//MARK: - 类型属性

//跟实例的存储型属性不同，必须给存储型类型属性指定默认值，因为类型本身没有构造器，也就无法在初始化过程中使用构造器给类型属性赋值。
//
//存储型类型属性是延迟初始化的，它们只有在第一次被访问的时候才会被初始化。
//即使它们被多个线程同时访问，系统也保证只会对其进行一次初始化，并且不需要对其使用 lazy 修饰符。

//MARK: - 类型属性语法
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
    // 计算型的类属性
    // 计算型的类属性
    // 计算型的类属性
    //class var xxx = "ddd" // 计算型的类属性
//    在为类定义计算型类型属性时，可以改用关键字 class 来支持子类对父类的实现进行重写。
    class var overrideableComputedTypeProperty: Int {
        return 107
    }
}

print(SomeStructure.storedTypeProperty)

//MARK: - 获取和设置类型属性的值
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





