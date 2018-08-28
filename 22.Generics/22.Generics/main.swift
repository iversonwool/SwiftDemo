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




//关联类型


protocol Container {
    associatedtype Item
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
}








struct Stack<Element>: Container {
    var items = [Element]()
    mutating func push(_ item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
    //Container protocol
    mutating func append(_ item: Element) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Element {
        return items[i]
    }
}


var stackOfStrings = Stack<String>()

stackOfStrings.push("uno")
stackOfStrings.push("dos")
print(stackOfStrings.items)

//扩展一个范型类型

extension Stack {
    var topItem: Element? {
        return items.isEmpty ? nil : items[items.count - 1]
    }
}

if let topItem = stackOfStrings.topItem {
    print(topItem)
}

//类型约束语法
//func someFunc<T: SomeClass, U: SomeProtocol>(someT: T, someU: U) {
//    //
//}
//类型约束实践
func findIndex(ofString valueToFind: String, in array: [String]) -> Int? {
    for (index, value) in array.enumerated() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}





//func findIndex<T>(of valueToFind: T, in array: [T]) -> Int? {
//    for (index, value) in array.enumerated() {
//        if value == valueToFind { //问题出在相等性检查上，即 "if value == valueToFind"。
//            return index
//        }
//    }
//    return nil
//}
//上面所写的函数无法通过编译。
//问题出在相等性检查上，即 "if value == valueToFind"。
//不是所有的 Swift 类型都可以用等式符（==）进行比较。
//比如说，如果你创建一个自定义的类或结构体来表示一个复杂的数据模型，
//那么 Swift 无法猜到对于这个类或结构体而言“相等”意味着什么。
//正因如此，这部分代码无法保证适用于每个可能的类型 T，当你试图编译这部分代码时会出现相应的错误。

//不过，所有的这些并不会让我们无从下手。
//Swift 标准库中定义了一个 Equatable 协议，该协议要求任何遵循该协议的类型必须实现等式符（==）及不等符（!=），
//从而能对该类型的任意两个值进行比较。所有的 Swift 标准类型自动支持 Equatable 协议。


func findIndex<T: Equatable>(of valueToFind: T, in array: [T]) -> Int? {
    for (index, value) in array.enumerated() {
        if value == valueToFind { //问题出在相等性检查上，即 "if value == valueToFind"。
            return index
        }
    }
    return nil
}



let doubleIndex = findIndex(of: 9.3, in: [3.14159, 0.1, 0.25])

print(doubleIndex ?? NSNotFound)


let stringIndex = findIndex(of: "Andrea", in: ["Mike", "Malcolm", "Andrea"])
print(stringIndex ?? NSNotFound)




//通过扩展一个存在的类型来指定关联类型
extension Array: Container {}



//在关联类型约束里使用协议
protocol SuffixableContainer: Container {
    associatedtype Suffix: SuffixableContainer where Suffix.Item == Item
    func suffix(_ size: Int) -> Suffix
}



extension Stack: SuffixableContainer {
    func suffix(_ size: Int) -> Stack {
        var result = Stack()
        for index in (count - size)..<count {
            result.append(self[index])
        }
        return result
    }
}


var stackOfInts = Stack<Int>()
stackOfInts.append(10)
stackOfInts.append(20)
stackOfInts.append(30)


let suffix = stackOfInts.suffix(2)

print(suffix)


//范型where语句
func allItemMatch<C1: Container, C2: Container>(_ someContainer: C1, _ anotherContainer: C2) -> Bool where C1.Item == C2.Item, C1.Item: Equatable {
    if someContainer.count != anotherContainer.count {
        return false
    }
    for i in 0..<someContainer.count {
        if someContainer[i] != anotherContainer[i] {
            return false
        }
    }
    return true
}

var stackOfStrings1 = Stack<String>()
stackOfStrings1.push("uno")
stackOfStrings1.push("dos")
stackOfStrings1.push("tres")

var arrayOfStrings = ["uno", "dos", "tres"]

if allItemMatch(stackOfStrings1, arrayOfStrings) {
    print("all match")
} else {
    print("not match")
}

//具有范型where子句的扩展


//具有范型where子句的关联类型


//范型下标



