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



var shoppingList = ["Eggs", nil, "Milk"]


//for item in shoppingList {
//    print("item => \(item)")
//}

for case let item? in shoppingList {
    print("item => \(item)")
}


for case .some(let item) in shoppingList {
    print(item)
    
}

print(shoppingList.count)

if shoppingList.isEmpty {
    print("not empty")
}

shoppingList.append(contentsOf: ["Bread"])

print(shoppingList)

shoppingList.append("Fruits")
print(shoppingList)

shoppingList[2...3] = ["Bananas", "Apples"]
print(shoppingList)

shoppingList.insert("Pear", at: 2)
print(shoppingList)

let removeElement = shoppingList.remove(at: 3)

print(removeElement, shoppingList)

let theLast = shoppingList.removeLast()
print(theLast, shoppingList)



// dictionary
// 字典是一种存储多个类型相同的值的容器。

var airports = ["TYO": "Tokyo", "DUB": "Dublin"]
print(airports)

airports["LHR"] = "London"
print(airports)
//print(airports, separator: "\n", terminator: "\n")

if let value = airports.updateValue("London 333", forKey: "LHR") {
    print("the old value is " + value)
}
print(airports)

if let value = airports["LHR"] {
    print(value)
}

// 复制nil 来删除一个键值对
airports["LHR"] = nil

print(airports)

// or

if let remove = airports.removeValue(forKey: "DUB") {
    print(remove)
}
print(airports)


for (key, value) in airports {
    print(key, "+", value)
}

