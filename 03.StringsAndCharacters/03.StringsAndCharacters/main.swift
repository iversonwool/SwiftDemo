//
//  main.swift
//  03.StringsAndCharacters
//
//  Created by LeeHow on 2018/8/20.
//  Copyright © 2018 LeeHow. All rights reserved.
//

import Foundation

print("Hello, World!")

//MARK:1.字符串字面量
let someString = "some string literal value"


//MARK:2.多行字符串字面量
let quotation = """
The White Rabbit put on his spectacles.  "Where shall I begin,
please your Majesty?" he asked.

"Begin at the beginning," the King said gravely, "and go on
till you come to the end; then stop."
"""
print(quotation)


print("---------------")
//如果你的代码中，多行字符串字面量包含换行符的话，则多行字符串字面量中也会包含换行符。
//如果你想换行，以便加强代码的可读性，但是你又不想在你的多行字符串字面量中出现换行符的话，你可以用在行尾写一个反斜杠（\）作为续行符。
let softWrappedQuotation = """
The White Rabbit put on his spectacles.  "Where shall I begin, \
please your Majesty?" he asked.

"Begin at the beginning," the King said gravely, "and go on \
till you come to the end; then stop."
"""
print(softWrappedQuotation)
print("---------------")

let lineBreaks = """

This string starts with a line break.
It also ends with a line break.

"""
print(lineBreaks)
print("---------------")




let indentString = """
This string starts with a line break.
    It also ends with a line break.
"""
print(indentString)
print("---------------")


//MARK:3.字符串字面量的特殊字符

//Unicode 标量，写成 \u{n}(u 为小写)，其中 n 为任意一到八位十六进制数且可用的 Unicode 位码。
let wiseWords = "\"Imagination is more important than knowledge\" - Einstein"
print(wiseWords)
let dollarSign = "\u{24}"
print(dollarSign)


let unicodeString = "\u{1F496}"
print(unicodeString)

// output
// 💖

//MARK:初始化空字符串
var empty = ""
var anotherEmpty = String()


if empty.isEmpty {
    print("empty string")
}


//MARK:字符串可变性
var s = "value🐶"
var hello = s
hello = "hello"
print("s is \(s)")

print(s.count)


//MARK:字符串是值类型
//func changeString(from s: String) {
//    s = "hello" + s
//}
//在实际编译时，Swift 编译器会优化字符串的使用，使实际的复制只发生在绝对必要的情况下，这意味着您将字符串作为值类型的同时可以获得极高的性能。

//MARK:使用字符


//MARK:连接字符串和字符
//1.运算符（+）
//2.运算符（+=）
//3.append()方法

let exclamationMark: Character = "!"
var welcome = "hello there"
welcome.append(exclamationMark)
print(welcome)

//
//注意
//
//您不能将一个字符串或者字符添加到一个已经存在的字符变量上，因为字符变量只能包含一个字符。

//多行字符串拼接
let badStart = """
one
two
"""


let end = """
three
"""


let goodStart = """
one
two

"""
print(badStart + end)
print(goodStart + end)

//MARK:字符串插值
//\(interpolation)


let multiplier = 3
let message = "\(multiplier) times 2.5 is \(Double(multiplier) * 2.5)"
print(message)

//MARK:Unicode
//MARK:Unicode标量
//MARK:可扩展的字形群集

let eAcute = "\u{e9}"
print(eAcute)
let combinedEAcute = "\u{65}\u{301}"
print(combinedEAcute)
print(eAcute.count)
print(combinedEAcute.count)

//单一的Character值

//MARK:计算字符数量

//注意在 Swift 中，使用可拓展的字符群集作为 Character 值来连接或改变字符串时，并不一定会更改字符串的字符数量。
var word = "cafe"
print("the number of characters in \(word) is \(word.count)")
// 打印输出 "the number of characters in cafe is 4"

word += "\u{301}"    // 拼接一个重音，U+0301

print("the number of characters in \(word) is \(word.count)")
// 打印输出 "the number of characters in café is 4"

for c in word {
    print(c)
}


let nsstring: NSString = "hello"
print(nsstring.length)
//
//另外需要注意的是通过 count 属性返回的字符数量并不总是与包含相同字符的 NSString 的 length 属性相同。
//NSString 的 length 属性是利用 UTF-16 表示的十六位代码单元数字，而不是 Unicode 可扩展的字符群集。


//MARK:访问和修改字符串
//你可以通过字符串的属性和方法来访问和修改它，当然也可以用下标语法完成。

//MARK:字符串索引
let greeting = "Guten Tag!"
print(greeting[greeting.startIndex])

greeting[greeting.index(before: greeting.endIndex)]//!
greeting[greeting.index(after: greeting.startIndex)]//u
print(greeting[greeting.index(greeting.startIndex, offsetBy: 7)])
//试图获取越界索引对应的 Character，将引发一个运行时错误。
//greeting[greeting.endIndex]
for index in greeting.indices {
//    print("\(greeting[index])", terminator: "")
    print("\(greeting[index]) ", separator: " ", terminator: "")
}
print("")
//
//注意
//
//您可以使用 startIndex 和 endIndex 属性或者 index(before:) 、index(after:) 和 index(_:offsetBy:)
//方法在任意一个确认的并遵循 Collection 协议的类型里面，如上文所示是使用在 String 中，您也可以使用在 Array、Dictionary 和 Set 中。


//MARK:插入和删除
print(welcome)

welcome.insert("?", at: welcome.endIndex)
print(welcome)
//offset 可以传负值
welcome.insert(contentsOf: "leehow", at: welcome.index(welcome.endIndex, offsetBy: -2))
print(welcome)

//删除末尾  ?
welcome.remove(at: welcome.index(before: welcome.endIndex))
print(welcome)
let range = welcome.index(welcome.endIndex, offsetBy: -7)..<welcome.index(before: welcome.endIndex)
welcome.removeSubrange(range)
print(welcome)
//注意
//
//您可以使用 insert(_:at:)、insert(contentsOf:at:)、remove(at:) 和 removeSubrange(_:)
//方法在任意一个确认的并遵循 RangeReplaceableCollection 协议的类型里面，如上文所示是使用在 String 中，您也可以使用在 Array、Dictionary 和 Set 中。

//MARK:子字符串
print(greeting)

let index = greeting.firstIndex(of: " ") ?? greeting.endIndex
let beginning = greeting[..<index]
print(beginning)

//当你需要长时间保存结果时，就把 SubString 转化为 String 的实例：
let newString = String(beginning)

//而 String 和 SubString 的区别在于性能优化上，SubString 可以重用原 String 的内存空间，
//或者另一个 SubString 的内存空间（String 也有同样的优化，但如果两个 String 共享内存的话，它们就会相等）。
//这一优化意味着你在修改 String 和 SubString 之前都不需要消耗性能去复制内存。
//就像前面说的那样，SubString 不适合长期存储 —— 因为它重用了原 String 的内存空间，原 String 的内存空间必须保留直到它的 SubString 不再被使用为止。

//注意
//
//String 和 SubString 都遵循 StringProtocol<//apple_ref/swift/intf/s:s14StringProtocolP> 协议，
//这意味着操作字符串的函数使用 StringProtocol 会更加方便。你可以传入 String 或 SubString 去调用函数。


//MARK:比较字符串
//MARK:字符串/字符相等


//字符串/字符可以用等于操作符（==）和不等于操作符（!=）
//MARK:前缀/后缀相等
//通过调用字符串的 hasPrefix(_:)/hasSuffix(_:) 方法来检查字符串是否拥有特定前缀/后缀，两个方法均接收一个 String 类型的参数，并返回一个布尔值。


//MARK:字符串的Unicode表示形式
//MARK:UTF-8表示
//MARK:UTF-16表示
//MARK:Unicode 标量表示
