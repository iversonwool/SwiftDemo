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



class Train: Vehicle {
    override func makeNoise() {
        print("Choo Choo")
    }
}



let train = Train()
train.makeNoise()

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




class AutomaticCar: Car {
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

//final
//can't inherit
//class AutomaticCar3: AutomaticCar2 {
//    //
//}





