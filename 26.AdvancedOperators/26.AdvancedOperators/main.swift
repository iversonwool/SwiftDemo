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


//位运算符

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



//溢出运算符
//溢出加法 &+
//溢出减法 &-
//溢出乘法 &*
//
//

//运算符函数
//类和结构体可以为现有的运算符提供自定义的实现，这通常被称为运算符重载。
//
//


struct Vector2D {
    var x = 0.0
    var y = 0.0
}


extension Vector2D {
    static func + (left: Vector2D, right: Vector2D) -> Vector2D {
        return Vector2D(x: left.x + right.x, y: left.y + right.y)
    }
    
    static prefix func - (vector: Vector2D) -> Vector2D {
        return Vector2D(x: -vector.x, y: -vector.y)
    }
    
    static func += (left: inout Vector2D, right: Vector2D) {
        left = left + right
    }
}




let vector1 = Vector2D(x: 3.0, y: 4.0)
let vector2 = Vector2D(x: 4.0, y: 5.0)
let vector  = vector1 + vector2
print(vector)






//前缀 后缀运算符
//要实现前缀或者后缀运算符，需要在声明运算符函数的时候在 func 关键字之前指定 prefix 或者 postfix 修饰符：



//复合赋值运算符


//extension Vector2D {
//
//}




var original = Vector2D(x: 1.0, y: 2.0)
let vectorToAdd = Vector2D(x: 3.0, y: 3.0)
original += vectorToAdd
print(original)




//
//注意
//
//不能对默认的赋值运算符（=）进行重载。只有组合赋值运算符可以被重载。
//同样地，也无法对三目条件运算符 （a ? b : c） 进行重载。


//
//Swift 为以下自定义类型提等价运算符供合成实现：
//
//只拥有遵循 Equatable 协议存储属性的结构体；
//只拥有遵循 Equatable 协议关联类型的枚举；
//没有关联类型的枚举。

infix operator +-: AdditionPrecedence


