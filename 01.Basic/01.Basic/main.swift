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



// 强制解析

// 可选绑定

// 隐式解析可选

//Float64

// first : the condition that code can continue
// second: the message that make code terminate
assert(min == -127, "min != -128")
print("continue")




