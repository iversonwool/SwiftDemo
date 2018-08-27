//
//  main.swift
//  22.Generics
//
//  Created by LeeHow on 2018/8/27.
//  Copyright © 2018 LeeHow. All rights reserved.
//

import Foundation

print("Hello, World!")
//
//注意
//
//在上面三个函数中，a 和 b 类型必须相同。如果 a 和 b 类型不同，那它们俩就不能互换值。
//Swift 是类型安全的语言，所以它不允许一个 String 类型的变量和一个 Double 类型的变量互换值。试图这样做将导致编译错误。
func swapTwoValues<T>(_ a: inout T, _ b: inout T) {
    let temporary = a
    a = b
    b = temporary
}


var someInt = 3
var anotherInt = 108

swapTwoValues(&someInt, &anotherInt)
print(someInt, anotherInt)


//标准库函数 swap 已实现该功能

//
//注意
//
//请始终使用大写字母开头的驼峰命名法（例如 T 和 MyTypeParameter）来为类型参数命名，以表明它们是占位类型，而不是一个值。



struct IntStack {
    var items = [Int]()
    mutating func push(_ item: Int) {
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }
}



struct Stack<Element> {
    var items = [Element]()
    mutating func push(_ item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
}


var stackOfStrings = Stack<String>()

stackOfStrings.push("uno")
stackOfStrings.push("dos")
print(stackOfStrings.items)












