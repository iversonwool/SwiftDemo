//
//  main.swift
//  02.BasicOperators
//
//  Created by LeeHow on 2018/8/20.
//  Copyright © 2018 LeeHow. All rights reserved.
//

import Foundation

print("Hello, World!")

var i = 1

i += 1

// i++ // no self increase


//
//“ The assignment operator (=) doesn’t return a value”
//
//Excerpt From: Apple Inc. “The Swift Programming Language (Swift 4.1).” iBooks.

//

// concat a string
let name = "LeeHow"


print("Hello, " + name + "!")

// no self increase decrease operators //


// 空合运算符 Nil Coalescing Operator
//
//空合运算符（a ?? b）将对可选类型 a 进行空判断，如果 a 包含一个值就进行解封，否则就返回一个默认值 b。
//表达式 a 必须是 Optional 类型。默认值 b 的类型必须要和 a 存储值的类型保持一致。


//a ?? b
// |
// V
//a != nil ? a! : b

//注意
//
//如果 a 为非空值（non-nil），那么值 b 将不会被计算。这也就是所谓的短路求值。

let defaultColorName = "red"
var userDefinedColorName: String?
var colorNameToUse = userDefinedColorName ?? defaultColorName
print(colorNameToUse) // red

userDefinedColorName = "green"
colorNameToUse = userDefinedColorName ?? defaultColorName
print(colorNameToUse) // green



// [1, 4)
for i in 1..<4 {
    print(i)
}

/*
 * 短路计算
 */

// A && B
// if A is false B will not be evaluate

// A || B
// if A is true B will not be evaluate










