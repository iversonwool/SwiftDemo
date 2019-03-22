//
//  main.swift
//  17.ErrorHandling
//
//  Created by LeeHow on 2018/8/24.
//  Copyright © 2018 LeeHow. All rights reserved.
//

import Foundation

print("Hello, World!")

//MARK: - 错误处理

//MARK: - 表示与抛出错误

//////////////////////////////////////////////////////
//在 Swift 中，错误用遵循 Error 协议的类型的值来表示。//////
//这个空协议表明该类型可以用于错误处理。////////////////////
//////////////////////////////////////////////////////

enum VendingMachingError: Error {
    case invalidSelection
    case insufficientFunds(coinsNeeded: Int) //Associated Values
    case outOfStock
}

// throw VendingMachingError.insufficientFunds(coinsNeeded: 5)


//MARK: - 处理错误
//4种错误处理方式
//你可以把函数抛出的错误传递给调用此函数的代码、
//用 do-catch 语句处理错误、
//将错误作为可选类型处理、
//或者断言此错误根本不会发生。


//MARK: - 用throws函数传递错误
struct Item {
    var price: Int
    var count: Int
    
}
//只有 throwing 函数可以传递错误。
//任何在某个非 throwing 函数内部抛出的错误只能在函数内部处理。


class VendingMachine {
    var inventory = [
        "Candy Bar": Item(price: 12, count: 7),
        "Chips"    : Item(price: 10, count: 4),
        "Pretzels" : Item(price: 11, count: 3)
    ]
    var coinsDeposited = 0
    func dispenseSnack(snack: String) {
        print("dispensing \(snack)")
    }
    func vend(itemName name: String) throws {
        guard let item = inventory[name] else {
            throw VendingMachingError.invalidSelection
        }
        guard item.count > 0 else {
            throw VendingMachingError.outOfStock
        }
        guard item.price <= coinsDeposited else {
            throw VendingMachingError.insufficientFunds(coinsNeeded: item.price - coinsDeposited)
        }
        coinsDeposited -= item.price
        var newItem = item
        newItem.count -= 1
        inventory[name] = newItem
        print("despensing \(name)")
    }
}

//dispense
//vt. 分配，分发；免除；执行
//vi. 免除，豁免


//
//在 vend(itemNamed:) 方法的实现中使用了 guard 语句来提前退出方法，
//确保在购买某个物品所需的条件中，有任一条件不满足时，能提前退出方法并抛出相应的错误。
//由于 throw 语句会立即退出方法，所以物品只有在所有条件都满足时才会被售出。

let favoriteSnacks = [
    "Alice": "Chips",
    "Bob": "Licorice",
    "Eve": "Pretzels",
]


func buyFavoriteSnack(person: String, vendingMachine: VendingMachine) throws {
    let snackName = favoriteSnacks[person] ?? "Candy Bar"
    //第一种方式：把函数抛出的错误传递给调用此函数的代码
    
    // 因为 vend(itemNamed:) 方法能抛出错误，所以在调用的它时候在它前面加了 try 关键字。
    // 因为 vend(itemNamed:) 方法能抛出错误，所以在调用的它时候在它前面加了 try 关键字。
    // 因为 vend(itemNamed:) 方法能抛出错误，所以在调用的它时候在它前面加了 try 关键字。
    try vendingMachine.vend(itemName: snackName)
}


//MARK: - 用Do-Catch处理错误
var vendingMachine = VendingMachine()

vendingMachine.coinsDeposited = 8
//第二种方式：用 do-catch 语句处理错误
do {
    try buyFavoriteSnack(person: "Alice", vendingMachine: vendingMachine)
} catch VendingMachingError.invalidSelection {
    print("invalidSelection")
} catch VendingMachingError.outOfStock {
    print("outOfStock")
} catch VendingMachingError.insufficientFunds(let coinsNeeded) {
    print("Insufficient funds. Please insert an additional \(coinsNeeded) coins.")
}



//MARK: - 将错误转换成可选值
func someThrowingFunction() throws -> Int {
    //
    return 1
}
//例如，在下面的代码中，x 和 y 有着相同的数值和等价的含义：
//如果在评估 try? 表达式时一个错误被抛出，那么表达式的值就是 nil。

//第三种方式：将错误作为可选类型处理
let x = try? someThrowingFunction()

let y: Int?
do {
    y = try someThrowingFunction()
} catch {
    y = nil
}


//第四种方式：或者断言此错误根本不会发生
//MARK： - 禁用错误传递
//
//有时你知道某个 throwing 函数实际上在运行时是不会抛出错误的，
//在这种情况下，你可以在表达式前面写 try! 来禁用错误传递，这会把调用包装在一个不会有错误抛出的运行时断言中。
//如果真的抛出了错误，你会得到一个运行时错误。
//

//let photo = try! loadImage(atPath: "./Resource/Jhon Appleseed.jpg")



//
//
//MARK: - 指定清理操作


//
//延迟执行的操作会按照它们声明的顺序从后往前执行——也就是说，第一条 defer 语句中的代码最后才执行，第二条 defer 语句中的代码倒数第二个执行，以此类推。
//最后一条语句会第一个执行。
//
//

func exists(filename name: String) -> Bool {
    return name == "file_one"
}
func processFile(filename: String) throws {
    if exists(filename: filename) {
//        let file = open(filename)
//        defer {
//            close(file)
//        }
//        while let line = try file.readline() {
//            // 处理文件。
//        }
        // close(file) 会在这里被调用，即作用域的最后。
    }
}


//该语句让你能执行一些必要的清理工作，不管是以何种方式离开当前代码块的——无论是由于抛出错误而离开，或是由于诸如 return、break 的语句。
//这种写法确实聪明，但这样却颠倒了函数的逻辑顺序，极大降低了代码的可读性。
//应该严格遵循 defer 在整个程序最后运行以释放已申请资源的原则，其他任何使用方法都可能让代码乱成一团。
//
postfix func ++(x: inout Int) -> Int {
    defer {
        x += 1
    }
    return x
}


var xx = 3
print(xx++)
print(xx)









