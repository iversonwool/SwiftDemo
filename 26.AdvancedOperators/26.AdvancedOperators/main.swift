//
//  main.swift
//  26.AdvancedOperators
//
//  Created by LeeHow on 2018/8/28.
//  Copyright © 2018 LeeHow. All rights reserved.
//

import Foundation

print("Hello, World!")


//
//与 C 语言中的算术运算符不同，Swift 中的算术运算符默认是不会溢出的。
//
//
//如果想让系统允许溢出行为，可以选择使用 Swift 中另一套默认支持溢出的运算符，比如溢出加法运算符（&+）。
//所有的这些溢出运算符都是以 & 开头的。


//MARK: - 位运算符

//
//按位取反运算符（~）可以对一个数值的全部比特位进行取反：

let initialBits: UInt8 = 0b00001111
let invertedBits = ~initialBits


extension UInt8 {
    func formatD() -> String {
        return String(format: "%d", self)
    }
}

print(initialBits.formatD())
print(invertedBits.formatD())


let someBits: UInt8 = 0b10110010
let moreBits: UInt8 = 0b01011110

print(someBits, moreBits)
print(someBits | moreBits)
let u_254 = 0b11111110
print(u_254)

//
//无符号整数的移位运算
//
//对无符号整数进行移位的规则如下：
//
//已经存在的位按指定的位数进行左移和右移。
//任何因移动而超出整型存储范围的位都会被丢弃。
//用 0 来填充移位后产生的空白位。
//这种方法称为逻辑移位

//
//
//
//当对整数进行按位右移运算时，遵循与无符号整数相同的规则，但是对于移位产生的空白位使用符号位进行填充，而不是用 0。
//
//
//这个行为可以确保有符号整数的符号位不会因为右移运算而改变，这通常被称为算术移位。



//MARK: - 溢出运算符
//溢出加法 &+
//溢出减法 &-
//溢出乘法 &*
//
//


//MARK: - 优先级和结合性

//MARK: - 运算符函数






struct Vector2D {
    var x = 0.0
    var y = 0.0
}


extension Vector2D {
    
    
    //MARK: - 运算符重载
    //类和结构体可以为现有的运算符提供自定义的实现，这通常被称为运算符重载。

    
    //MARK: - 中缀运算符
    //算术加法运算符是一个二元运算符，因为它是对两个值进行运算，同时它还可以称为中缀（zhong zhui）运算符，因为它出现在两个值中间。
    
    static func + (left: Vector2D, right: Vector2D) -> Vector2D {
        return Vector2D(x: left.x + right.x, y: left.y + right.y)
    }
    
    //MARK: - 前缀和后缀运算符
    //要实现前缀或者后缀运算符，需要在声明运算符函数的时候在 func 关键字之前指定 prefix 或者 postfix 修饰符：
    static prefix func - (vector: Vector2D) -> Vector2D {
        return Vector2D(x: -vector.x, y: -vector.y)
    }
    
    //MARK: - 复合赋值运算符
    static func += (left: inout Vector2D, right: Vector2D) {
        left = left + right
    }
}

let vector1 = Vector2D(x: 3.0, y: 4.0)
let vector2 = Vector2D(x: 4.0, y: 5.0)
let vector  = vector1 + vector2
print(vector)

var original = Vector2D(x: 1.0, y: 2.0)
let vectorToAdd = Vector2D(x: 3.0, y: 3.0)
original += vectorToAdd
print(original)

//注意
///不能对默认的赋值运算符（=）进行重载。只有组合赋值运算符可以被重载。
///同样地，也无法对三目条件运算符 （a ? b : c） 进行重载。


//MARK: - 等价运算符
//通常情况下，自定义的类和结构体没有对等价运算符进行默认实现，
//等价运算符通常被称为相等运算符（==）与不等运算符（!=）


extension Vector2D: Equatable {
    static func ==(left: Vector2D, right: Vector2D) -> Bool {
        return left.x == right.x && left.y == right.y
    }
}

//通常情况下你并不需要自己再去实现“不等”运算符（!=）。
//标准库对于“不等”运算符提供了默认的实现，它简单地将“相等”运算符的结果进行取反后返回。

//
//Swift 为以下自定义类型提等价运算符供合成实现：
//
//只拥有遵循 Equatable 协议存储属性的结构体；

struct Vector3D: Equatable {
    var x = 0.0, y = 0.0, z = 0.0
    
}
//只拥有遵循 Equatable 协议关联类型的枚举；
//没有关联类型的枚举。


//MARK: - 自定义运算符
//新的运算符要使用 operator 关键字在***全局作用域***内进行定义，
//同时还要***指定 prefix、infix 或者 postfix 修饰符***：


prefix operator +++

extension Vector2D {
    static prefix func +++(vector: inout Vector2D) -> Vector2D {
        vector += vector
        return vector
    }
}

//中缀运算符需要指定优先级
//https://developer.apple.com/documentation/swift/swift_standard_library/operator_declarations
infix operator +-: AdditionPrecedence

extension Vector2D {
    static func +-(left: Vector2D, right: Vector2D) -> Vector2D {
        return Vector2D(x: left.x + right.x, y: left.y - right.y)
    }
}

//注意

//当定义前缀与后缀运算符的时候，我们并没有指定优先级。
//然而，如果对同一个值同时使用前缀与后缀运算符，则后缀运算符会先参与运算。
