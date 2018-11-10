//
//  main.swift
//  DemoClassesAndStructures
//
//  Created by 李浩 on 2018/8/19.
//  Copyright © 2018 李浩. All rights reserved.
//

import Foundation

print("Hello, World!")

//MARK: - 结构体和类对比
//

//与结构体相比，类还有如下的附加功能：
//
//继承允许一个类继承另一个类的特征
//类型转换允许在运行时检查和解释一个类实例的类型
//析构器允许一个类实例释放任何其所被分配的资源
//引用计数允许对一个类的多次引用


//类支持的附加功能是以增加复杂性为代价的。
//作为一般准则，优先使用结构体和枚举，因为它们更容易理解，仅在适当或必要时才使用类。


//MARK: - 类型定义的语法
// define a structure

struct Resolution {
    //
    var width = 0
    var height = 0
    
}

//define a class
class VedioMode {
    //
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?
    
}

//MARK: - 结构体和类的实例
// generate a instace
let someResolution = Resolution()
let someVedioMode = VedioMode()


//MARK: - 属性访问
// access property
print("the width of someResolution is \(someResolution.width)")

print("the width of someVedioMode is \(someVedioMode.resolution.width)")

someVedioMode.resolution.width = 1920


//MARK: - 结构体类型的逐一成员构造器
let vga = Resolution(width: 640, height: 960)

//let someVedioMode = VedioMode()

//MARK: - 结构体和枚举是值类型
let hd = Resolution(width: 1920, height: 1080)
var cinema = hd
cinema.width = 2048
print("cinema is now \(cinema.width) pixel wide")

print("hd is still \(hd.width) pixle wide")

//print("hd => %p", hd)

enum CompasssPoint {
    case North, South, East, West
}
var currentDirection = CompasssPoint.West
let rememberedDirection = currentDirection
currentDirection = .East
if rememberedDirection == .West {
    print("the remembered direction is still .West")
}


//MARK: - 类是引用类型

let tenEighty = VedioMode()
tenEighty.resolution = hd
tenEighty.interlaced = true
tenEighty.name = "1080i"
tenEighty.frameRate = 25.0

let alsoTenEighty = tenEighty
alsoTenEighty.frameRate = 30.0
print("the frameRate property of tenEighty is now \(tenEighty.frameRate)")

// constant
//tenEighty = VedioMode()

//MARK: - 恒等运算符
//判定两个常量或者变量是否引用同一个类实例有时很有用。

if tenEighty === alsoTenEighty {
    print("tenEighty is equal to alsoTenEighty")
}



var ages = ["Peter": 23, "Wei": 35, "Anish": 65, "Katya": 19]
var copiedAges = ages

copiedAges["Peter"] = 24
if let peterAge = ages["Peter"] {
    print(peterAge)
}

var a = [1, 2, 3]
var b = a
var c = a

print(a[0])
print(b[0])
print(c[0])



a[0] = 42
print(a[0])
print(b[0])
print(c[0])


//MARK: - 指针


//Swift 中引用了某个引用类型实例的常量或变量，
//与 C 语言中的指针类似，不过它并不直接指向某个内存地址，
//也不要求你使用星号（*）来表明你在创建一个引用。
//相反，Swift 中引用的定义方式与其它的常量或变量的一样。
//如果需要直接与指针交互，你可以使用标准库提供的指针和缓冲区类型
//—— 参见 手动管理内存。



//https://developer.apple.com/documentation/swift/swift_standard_library/manual_memory_management
