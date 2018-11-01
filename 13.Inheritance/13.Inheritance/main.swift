//
//  main.swift
//  13.Inheritance
//
//  Created by LeeHow on 2018/8/22.
//  Copyright © 2018 LeeHow. All rights reserved.
//

import Foundation

print("Hello, World!")



//class Vehicle {
//    var currentSpeed = 0.0
//    var description: String {
//        return "traveling at \(currentSpeed) miles per hour"
//    }
//    func makeNoise() {
//        // do nothing
//    }
//}
//
//let someVehicle = Vehicle()
//print(someVehicle.description)
//
//
//
//
//class Bicycle: Vehicle {
//    var hasBasket = false
//
//}
//
//
//
//let bicycle = Bicycle()
//bicycle.hasBasket = true
//bicycle.currentSpeed = 15.0
//print(bicycle.description)
//
//
//
//class Tandem: Bicycle {
//    var currentNumberOfPassengers = 0
//
//}
//let tandem = Tandem()
//
//tandem.hasBasket = true
//tandem.currentNumberOfPassengers = 2
//tandem.currentSpeed = 20.0
//print(tandem.description)
//



//Mark: - 继承

//可以为任何属性添加属性观察器，无论它原本被定义为存储型属性还是计算型属性。


//MARK: - 定义一个基类
class Vehicle {
    //    final var currentSpeed = 0.0
    var currentSpeed = 0.0
    
    var description: String {
        return "traveling at \(currentSpeed) miles per hour"
    }
    func makeNoise() {
        // do nothing
    }
    
    
}

//MARK: - 子类生成

class Bicycle: Vehicle {
    var hasBasket = false
    
}





class Tandem: Bicycle {
    var currentNumberOfPassengers = 0
    
}
let tandem = Tandem()
tandem.currentSpeed = 30.0
print(tandem.description)
tandem.hasBasket = true
tandem.currentNumberOfPassengers = 2

//MARK: - 重写




//MARK: - 访问超类的方法，属性及下标
//在方法 someMethod() 的重写实现中，可以通过 super.someMethod() 来调用超类版本的 someMethod() 方法。
//在属性 someProperty 的 getter 或 setter 的重写实现中，可以通过 super.someProperty 来访问超类版本的 someProperty 属性。
//在下标的重写实现中，可以通过 super[someIndex] 来访问超类版本中的相同下标。



//MARK: - 重写方法
class Train: Vehicle {
    override func makeNoise() {
        print("Choo Choo")
    }
}



let train = Train()
train.makeNoise()


//MARK: - 重写属性

//MARK: - 重写属性的gGetters 和 Setters


//warning
//你可以将一个继承来的只读属性重写为一个读写属性，只需要在重写版本的属性里提供 getter 和 setter 即可。
//但是，你不可以将一个继承来的读写属性重写为一个只读属性。
class Car: Vehicle {
    var gear = 1
    override var description: String {
        return super.description + " in gear \(gear)"
    }
}

let car = Car()
car.currentSpeed = 89
car.gear = 3
print(car.description)



//MARK: - 重写属性观察器
class AutomaticCar: Car {
    //重写的属性不能设置初始值？？
    override var currentSpeed: Double {
        didSet {
            gear = Int(currentSpeed / 10.0) + 1
        }
    }
}


final class AutomaticCar2: Car {
    override var currentSpeed: Double {
        didSet {
            print(oldValue)
        }
    }
}

//MARK: - 防止重写

//你可以通过把方法，属性或下标标记为*final*来防止它们被重写，只需要在声明关键字前加上 final 修饰符即可
//（例如：final var，final func，final class func，以及 final subscript）。

//你可以通过在关键字 class 前添加 final 修饰符（final class）来将整个类标记为 final 的。
//这样的类是不可被继承的，试图继承这样的类会导致编译报错。
//final
//can't inherit
//class AutomaticCar3: AutomaticCar2 {
//    //
//}


//struct Father {
//    var name = "father"
//    
//}
//
//
//struct Son: Father {
//    //
//}
