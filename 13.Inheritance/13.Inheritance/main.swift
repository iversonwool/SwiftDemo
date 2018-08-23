//
//  main.swift
//  13.Inheritance
//
//  Created by LeeHow on 2018/8/22.
//  Copyright © 2018 LeeHow. All rights reserved.
//

import Foundation

print("Hello, World!")



class Vehicle {
    var currentSpeed = 0.0
    var description: String {
        return "traveling at \(currentSpeed) miles per hour"
    }
    func makeNoise() {
        // do nothing
    }
}

let someVehicle = Vehicle()
print(someVehicle.description)




class Bicycle: Vehicle {
    var hasBasket = false
    
}



let bicycle = Bicycle()
bicycle.hasBasket = true
bicycle.currentSpeed = 15.0
print(bicycle.description)



class Tandem: Bicycle {
    var currentNumberOfPassengers = 0
    
}
let tandem = Tandem()

tandem.hasBasket = true
tandem.currentNumberOfPassengers = 2
tandem.currentSpeed = 20.0
print(tandem.description)












