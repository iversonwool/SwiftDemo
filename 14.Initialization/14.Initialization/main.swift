//
//  main.swift
//  14.Initialization
//
//  Created by LeeHow on 2018/8/23.
//  Copyright © 2018 LeeHow. All rights reserved.
//

import Foundation

import QuartzCore

print("Hello, World!")




class XXX {
    var name: String
    init(name: String) {
        self.name = name
    }
}


let xxx = XXX(name: "xxx")

////////////////////////////////////////////////////////
//类和结构体在创建实例时，必须为所有存储型属性设置合适的初始值。//
//存储型属性的值不能处于一个未知的状态。//////////////////////
////////////////////////////////////////////////////////


//注意
//
//当你为存储型属性设置默认值或者在构造器中为其赋值时，它们的值是被直接设置的，不会触发任何属性观察者。



struct Fahrenheit {
//    var temperature: Double
//    init() {
//        temperature = 32.0
//    }
    var temperature = 32.0
    
}

var f = Fahrenheit()
print("the default temperature is \(f.temperature) Fahrenheit")


struct Celsius {
    var temperatureInCelsius: Double
    init(fromFahrenheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }
    init(_ celsius: Double) {
        temperatureInCelsius = celsius
    }
}

let boilingPointOfWater = Celsius(fromFahrenheit: 212.0)

print(boilingPointOfWater.temperatureInCelsius)

let freezingPointOfWater = Celsius(fromKelvin: 273.15)
print(freezingPointOfWater.temperatureInCelsius)



struct Color {
    let red, green, blue: Double
    init(red: Double, green: Double, blue: Double) {
        self.red   = red
        self.green = green
        self.blue  = blue
    }
    init(white: Double) {
        red   = white
        green = white
        blue  = white
    }
}


//let magenta = Color(1.0, 1.0, 1.0)

let bodyTemperature = Celsius(37.0)



//warning
//声明SurveyQuestion是class 后面的response可以被赋值
//声明SurveyQuestion是struct 后面的response不可以被赋值

class SurveyQuestion {
//    var text: String
    let text: String
    
    var response: String?
    init(text: String) {
        self.text = text
    }
    func ask() {
        print(text)
    }
}



let cheeseQuestion = SurveyQuestion(text: "do you like cheese?")

cheeseQuestion.ask()
cheeseQuestion.response = "yes, I do"


//
//注意
//
//对于类的实例来说，它的常量属性只能在定义它的类的构造过程中修改；不能在子类中修改。




struct Size {
    var width = 0.0, height = 0.0
    
}
let twoByTwo = Size(width: 2.0, height: 2.0)



// 构造器代理
//MARK:值类型的构造器代理

///////////////////////////////////////
//值类型（结构体和枚举类型）不支持继承///////
///////////////////////////////////////


struct Point {
    var x = 0.0, y = 0.0
    
}

struct Rect {
    var origin = Point()
    var size = Size()
//    init() {
//
//    }
    //逐一成员构造器
    init(origin: Point, size: Size) {
//        self.init() // 不能调用init 方法 除非自己显示定义 init方法
        self.origin = origin
        self.size   = size
//        请注意，如果你为某个值类型定义了一个自定义的构造器，
//        你将无法访问到默认构造器（如果是结构体，还将无法访问逐一成员构造器）
    }
    init(center: Point, size: Size) {
        let originX = center.x - size.width / 2
        let originY = center.y - size.height / 2
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}

//注意
//
//假如你希望默认构造器、逐一成员构造器以及你自己的自定义构造器都能用来创建实例，
//可以将自定义的构造器写到扩展（extension）中，而不是写在值类型的原始定义中。

//MARK:类的继承和构造过程
//类的构造器代理规则

//规则 1
//
//指定构造器必须调用其直接父类的的指定构造器。
//
//规则 2
//
//便利构造器必须调用同类中定义的其它构造器。
//
//规则 3
//
//便利构造器最后必须调用指定构造器。
//
//一个更方便记忆的方法是：
//
//指定构造器必须总是向上代理
//便利构造器必须总是横向代理

//两段式构造过程


class Vehicle {
    var numberOfWheels = 0
    var description: String {
        return "\(numberOfWheels) wheel(s)"
    }
}

let vehicle = Vehicle()
print(vehicle.description)

class Bicycle: Vehicle {
    override init() {
        super.init()
        //这个方法的作用是调用 Bicycle 的父类 Vehicle 的默认构造器。
        //这样可以确保 Bicycle 在修改属性之前，它所继承的属性 numberOfWheels 能被 Vehicle 类初始化。
        numberOfWheels = 2
        //注意
        //子类可以在初始化时修改继承来的变量属性，但是不能修改继承来的常量属性。
    }
}

let bicycle = Bicycle()
print(bicycle.description)


class Food {
    var name: String
    init(name: String) {
        self.name = name
    }
    
    convenience init() {
        print("先调用父类继承的 convenience init 方法")
        self.init(name: "[Unnamed]")
    }
}


let namedMeat = Food(name: "Bacon")
print(namedMeat.name)


let mysteryMeat = Food()

print(mysteryMeat.name)




class RecipeIngredient: Food {
    var quantity: Int
    init(name: String, quantity: Int) {
        //指定构造器必须保证它所在类的所有属性都必须先初始化完成，之后才能将其它构造任务向上代理给父类中的构造器。
        self.quantity = quantity
        super.init(name: name)
    }
    override convenience init(name: String) {
        print("再调用自己重写的父类的 init(name:) 方法")
        self.init(name: name, quantity: 1)
    }
}


let oneMysteryItem = RecipeIngredient()
print("see ---- \(oneMysteryItem.quantity)")





class ShoppingListItem: RecipeIngredient {

    var purchased = false
    var description: String {
        var output = "\(quantity) x \(name)"
        output += purchased ? " ✅" : " ❌"
        return output
    }
}

var breakfastList = [
    ShoppingListItem(),
    ShoppingListItem(name: "Bacon"),
    ShoppingListItem(name: "Eggs", quantity: 6)
]

breakfastList[0].name = "Orange juice"
breakfastList[0].purchased = true


for item in breakfastList {
    print(item.description)
}

let wholeNumber: Double = 12345.0
let pi = 3.14

if let valueMaintained = Int(exactly: wholeNumber) {
    print("\(wholeNumber) conversion to Int maintains value of \(valueMaintained)")
}


struct Animal {
    let spcies: String
    init?(spcies: String) {
        if spcies.isEmpty {
            return nil
        }
        self.spcies = spcies
    }
}


let someCreature = Animal(spcies: "Giraffe")
if let giraffe = someCreature {
    print(giraffe.spcies)
}


class Document {
    var name: String?
    init() {}
    init?(name: String) {
        if name.isEmpty {
            return nil
        }
        self.name = name
    }
}

class AutomaticallyNamedDocument: Document {
    override init() {
        super.init()
        self.name = "[Untitled]"
    }
    override init(name: String) {
        super.init()
        if name.isEmpty {
            self.name = "[Untitled]"
        } else {
            self.name = name
        }
    }
}

class UntitledDocument: Document {
    override init() {
        super.init(name: "[Untitled]")!
        //在这个例子中，如果在调用父类的可失败构造器 init?(name:) 时传入的是空字符串，那么强制解包操作会引发运行时错误。
        //不过，因为这里是通过非空的字符串常量来调用它，所以并不会发生运行时错误。
    }
}




class SomeClass {
    required init() {
        
    }
}

class SomeSubclass: SomeClass {
    required init() {
        //
    }
    let someProperty: Double = {
        return 2.0
    }()
    
}


//
//let value = {
//    () -> Int in
//        return 32
//}
//
//
//print(value)


//MARK:test code

//let iterations = 1_000_000
let iterations = 100_000

class Employee {
    var name: String
    init(name: String) {
        self.name = name
    }
    func didSomething() -> Bool {
        //some complicated implementation
        //details go here
        //return false
        return true
    }
}

let tim = Employee(name: "Tim Cook")
let startTime = CFAbsoluteTimeGetCurrent()
for _ in 1...iterations {
    if tim.didSomething() {
        print("Yes!")
    }
}

let endTime = CFAbsoluteTimeGetCurrent()
let result = endTime - startTime



print(result)


//CACurrentMediaTime()
