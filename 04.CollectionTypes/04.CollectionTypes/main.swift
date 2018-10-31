//
//  main.swift
//  04.CollectionTypes
//
//  Created by LeeHow on 2018/8/20.
//  Copyright © 2018 LeeHow. All rights reserved.
//

import Foundation

print("Hello, World!")


let names = ["Tom",
             nil,
             "Peter",
             nil,
             "Harry"]


//let valid = names.flatMap { $0 }
let valid = names.compactMap { $0 }
print(valid)


//MARK: - 集合的可变性
var arr1 = ["zero", "first"]
arr1.append("second")
print(arr1)
let arr2 = ["zero", "first"]
//如果我们把 Arrays、Sets 或 Dictionaries 分配成常量，那么它就是不可变的，它的大小和内容都不能被改变。
//arr2[1] = "first" //Cannot assign through subscript: 'arr2' is a 'let' constant

//MARK: - 数组
//MARK: - 数组的简单语法
//Array<Element>形式
var arr3: Array<String> = ["Hello"]
//[Element]形式
var arr4: [String] = ["Hello"]

//MARK: - 创建一个空数组
var someInts = [Int]()





//MARK: - 创建一个带有默认值的数组
var threeDoubles = Array(repeating: 0.0, count: 3)
print(threeDoubles)

//MARK: - 通过两个数组相加创建一个数组
var anotherThreeDoubles = Array(repeating: 2.5, count: 3)
var sixDoubles = threeDoubles + anotherThreeDoubles
print(sixDoubles)

//MARK: - 用数组字面量构造数组
// 类型推断
//var shoppingList = ["Eggs", nil, "Milk"]


//var shoppingList: [String] = ["Eggs", "Milk"]
//由于 Swift 的类型推断机制，当我们用字面量构造只拥有相同类型值数组的时候，我们不必把数组的类型定义清楚。
var shoppingList = ["Eggs", "Milk"]

//for item in shoppingList {
//    print("item => \(item)")
//}

//for case let item? in shoppingList {
//    print("item => \(item)")
//}

//
//for case .some(let item) in shoppingList {
//    print(item)
//
//}

print(shoppingList.count)
//MARK: - 访问和修改数组

if shoppingList.isEmpty {
    print("not empty")
}



shoppingList.append(contentsOf: ["Bread"])
//shoppingList.app

print(shoppingList)

//添加
//使用加法赋值运算符（+=）
shoppingList += ["Baking Powder"]

//添加
shoppingList.append("Fruits")
print(shoppingList)

//替换
shoppingList[2...3] = ["Bananas", "Apples"]
print(shoppingList)

//插入
shoppingList.insert("Pear", at: 2)
print(shoppingList)

//删除
let removeElement = shoppingList.remove(at: 3)

print(removeElement, shoppingList)

let theLast = shoppingList.removeLast()
print(theLast, shoppingList)

//MARK: - 数组的遍历
for item in shoppingList {
    print(item)
}

for (index, value) in shoppingList.enumerated() {
    print("Item \(index): \(value)")
}


//MARK: - 字典
// dictionary
// 字典是一种存储多个类型相同的值的容器。

//MARK: - 字典类型简化语法

//MARK: - 创建一个空字典
var namesOfIntegers = [Int: String]()
namesOfIntegers[16] = "sixteen"
print(namesOfIntegers)
//将一个字典置空
namesOfIntegers = [:]

//MARK: - 用字典字面量创建字典
//var airports: [String: String] = ["TYO": "Tokyo", "DUB": "Dublin"]

//和数组一样，我们在用字典字面量构造字典时，如果它的键和值都有各自一致的类型，那么就不必写出字典的类型。
var airports = ["TYO": "Tokyo", "DUB": "Dublin"]
print(airports)

//MARK: - 访问和修改字典
//增
airports["LHR"] = "London"
print(airports)
//print(airports, separator: "\n", terminator: "\n")

//改
if let value = airports.updateValue("London 333", forKey: "LHR") {
    print("the old value is " + value)
}
print(airports)

//查
if let value = airports["LHR"] {
    print(value)
}

//删
//方式一 赋值nil 来删除一个键值对
airports["LHR"] = nil

print(airports)

// or方式二
if let remove = airports.removeValue(forKey: "DUB") {
    print(remove)
}
print(airports)

//MARK: - 字典遍历
for (key, value) in airports {
    print(key, "+", value)
}
