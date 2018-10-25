//
//  main.swift
//  01.Basic
//
//  Created by LeeHow on 2018/8/20.
//  Copyright © 2018 LeeHow. All rights reserved.
//

import Foundation

print("Hello, World!")


// 在同一行声明多个变量
var x = 0.0, y = 0.0, z = 0.0

print(x, y, z)

// allow declare different type
var s = "hello", word = 4
print(s, word)


var sssString = "string"
var xxxString: String
xxxString = "xxxString"
//
print(sssString, xxxString)

// cannot use key word if you insist do this
// like this
var `delete` = "sss"
print(delete)


// comment

//
/*
 comment
 */

/*
 xxx
 
 /* nested comment is allowed */
 */


let cat = "Hello Kitty"; print(cat); // need a semicolon ;






let hexadecimal = 0xC.3p0 // 1 / 16 * 3
print(hexadecimal)

let oneMillion = 1_000_000
print(oneMillion)

let min = Int8.min
print(min)


//typealias AudioSample = UInt16







//optionals

//注意

//C 和 Objective-C 中并没有可选类型这个概念。
//最接近的是 Objective-C 中的一个特性，一个方法要不返回一个对象要不返回 nil，nil 表示“缺少一个合法的对象”。
//然而，这只对对象起作用——对于结构体，基本的 C 类型或者枚举类型不起作用。
//对于这些类型，Objective-C 方法一般会返回一个特殊值（比如 NSNotFound）来暗示值缺失。
//这种方法假设方法的调用者知道并记得对特殊值进行判断。
//然而，Swift 的可选类型可以让你暗示任意类型的值缺失，并不需要一个特殊值。


//nil
//注意
//
//nil 不能用于非可选的常量和变量。
//如果你的代码中有常量或者变量需要处理值缺失的情况，请把它们声明成对应的可选类型。
//注意
//
//Swift 的 nil 和 Objective-C 中的 nil 并不一样。
//在 Objective-C 中，nil 是一个指向不存在对象的指针。
//在 Swift 中，nil 不是指针——它是一个确定的值，用来表示值缺失。
//任何类型的可选状态都可以被设置为 nil，不只是对象类型。

// 强制解析 forced unwrapping

//注意
//
//使用 ! 来获取一个不存在的可选值会导致运行时错误。
//使用 ! 来强制解析值之前，一定要确定可选包含一个非 nil 的值。

let xxx: Optional<Int> = Int("43")





let convertedNumber = Int("123")

if convertedNumber != nil {
    print("converted number is \(convertedNumber!)")
}


// 可选绑定 optional bindling

if let convertedNumber = Int("456") {
    print("can be converted, the number is \(convertedNumber)")
}
//注意
//
//在 if 条件语句中使用常量和变量来创建一个可选绑定，仅在 if 语句的句中（body）中才能获取到值。
//相反，在 guard 语句中使用常量和变量来创建一个可选绑定，仅在 guard 语句外且在语句后才能获取到值，请参考提前退出。



// 隐式解析可选 implicitly unwarpped optionals
//
//隐式解析可选类型主要被用在 Swift 中类的构造过程中，请参考无主引用以及隐式解析可选属性。

/////////////////////////////////////////////////////////////////////////
//你可以把隐式解析可选类型当做一个可以自动解析的可选类型。////////////////////////
//你要做的只是声明的时候把感叹号放到类型的结尾，而不是每次取值的可选名字的结尾。/////
////////////////////////////////////////////////////////////////////////


let assumedString: String! = "An implicitly unwrapped optional string"
let implicitString = assumedString //不需要感叹号
//print(implicitString!)


//注意
//
//如果你在隐式解析可选类型没有值的时候尝试取值，会触发运行时错误。
//和你在没有值的普通可选类型后面加一个惊叹号一样。
//
//注意
//
//如果一个变量之后可能变成 nil 的话请不要使用隐式解析可选类型。
//如果你需要在变量的生命周期中判断是否是 nil 的话，请使用普通可选类型。






//Float64

// first : the condition that code can continue
// second: the message that make code terminate
//assert(min == -127, "min != -128")
//print("continue")


//some test 

