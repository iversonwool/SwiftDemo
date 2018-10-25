//
//  main.swift
//  07.Closures
//
//  Created by LeeHow on 2018/8/21.
//  Copyright © 2018 LeeHow. All rights reserved.
//

import Foundation

print("Hello, World!")

//MARK:闭包表达式


//////闭包表达式语法
//{ (parameters) -> return type in
//    statements
//}
let isHello = { (_ param: String) -> Bool in
    return param == "Hello"
}("Hello")
print(isHello)

//////排序方法
//原数组
let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]

//排序func
func backward(_ s1: String, _ s2: String) -> Bool {
    return s1 > s2
}

//新数组
let newOrder = names.sorted(by: backward)
print(newOrder)

//使用内联闭包改写
let newOrder2 = names.sorted(by: { (s1: String, s2: String) -> Bool in
    return s1 > s2
})

//////1.根据上下文推断类型 再次改写

////////////////由于Swift的类型推断特性 不用显示声明参数和返回值类型
////////////////可以简单改为
//let newOrder3 = names.sorted { (s1, s2) -> Bool in
//    return s1 > s2
//}
let newOrder3 = names.sorted(by: { s1, s2 in
    return s1 > s2
})
print(newOrder3)

//////2.单表达式闭包隐式返回 再次改写

let newOrder4 = names.sorted(by: { s1, s2 in
    s1 > s2
})
//////参数名称缩写 再次改写
let newOrder5 = names.sorted(by: { $0 > $1 })

//////运算符方法 再次改写
//////////Swift 的 String 类型定义了关于大于号（>）的字符串实现，其作为一个函数接受两个 String 类型的参数并返回 Bool 类型的值。
//////////而这正好与 sorted(by:) 方法的参数需要的函数类型相符合。

let newOrder6 = names.sorted(by: >)
//////////newOrder1 ～ newOrder6是没有使用尾随闭包进行调用

//MARK:尾随闭包

//////////使用尾随闭包调用
//////////////如果你需要将一个很长的闭包表达式作为最后一个参数传递给函数，可以使用尾随闭包来增强函数的可读性。
//尾随闭包是一个书写在函数括号之后的闭包表达式，函数支持将其作为最后一个参数调用。
//在使用尾随闭包时，你不用写出它的参数标签：
let newOrder7 = names.sorted() { $0 > $1 } //没写出参数标签by


///////////////如果闭包表达式是函数或方法的唯一参数，则当你使用尾随闭包时，你甚至可以把 () 省略掉：
let newOrder8 = names.sorted { $0 > $1 }


//尾随闭包示例
let digitNames = [
    0: "Zero", 1: "One", 2: "Two",   3: "three", 4: "Four",
    5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
]

let numbers = [16, 57, 520]

let strings = numbers.map { (number) -> String in
    var number = number
    var output = ""
    while number > 0 {
        output = digitNames[number % 10]! + output
        number /= 10
    }
    return output
}
print(strings)

//MARK:值捕获

func makeIncrement(forIncrement amount: Int) -> () -> Int {
    var runningTotal = 0
    func increment() -> Int {
        runningTotal += amount
        return runningTotal
    }
    return increment
}

let incrementByTen = makeIncrement(forIncrement: 10)
print(incrementByTen())//10
print(incrementByTen())//20
print(incrementByTen())//30


//MARK:闭包是引用类型
let alsoIncrementByTen = incrementByTen
print(alsoIncrementByTen())//40


//MARK:逃逸闭包
//////当一个闭包作为参数传到一个函数中，但是这个闭包在函数返回之后才被执行，我们称该闭包从函数中逃逸。
//////将一个闭包标记为 @escaping 意味着你必须在闭包中显式地引用 self

var completionHandlers: [() -> Void] = []
func someFuncWithEscapingClosure(completionHandler: @escaping () -> Void) {
    completionHandlers.append(completionHandler)
}

func someFuncWithoutNonescapingClosure(closure: () -> Void) {
    closure()
}



class SomeClass {
    var x = 10
    func doSomething() {
        someFuncWithEscapingClosure {
            self.x = 100
        }
        someFuncWithoutNonescapingClosure {
            x = 200
        }
    }
    
}

let instance = SomeClass()
instance.doSomething()
print(instance.x)

completionHandlers.first?()
print(instance.x)


//MARK:自动闭包
//自动闭包是一种自动创建的闭包，用于包装传递给函数作为参数的表达式。
//这种闭包不接受任何参数，当它被调用的时候，会返回被包装在其中的表达式的值。
var customersInline = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
print(customersInline.count)

let customerProvider = { customersInline.remove(at: 0) }
//customerProvider 的类型不是 String，而是 () -> String，一个没有参数且返回值为 String 的函数
print(customersInline.count)

print("Now serving \(customerProvider())")
print(customersInline.count)

//将闭包作为参数传递给函数时，你能获得同样的延时求值行为。

func serve(customer customerProvider: () -> String) {
    print("Now serving \(customerProvider())")
}
//serve { () -> String in
//    customersInline.remove(at: 0)
//}
serve(customer: { customersInline.remove(at: 0) })//单表达式闭包隐式返回
print(customersInline)


//@autoclosure
//下面这个版本的 serve(customer:) 完成了相同的操作，不过它并没有接受一个显式的闭包，
//而是通过将参数标记为 @autoclosure 来接收一个自动闭包。
//现在你可以将该函数当作接受 String 类型参数（而非闭包）的函数来调用。
//customerProvider 参数将自动转化为一个闭包，因为该参数被标记了 @autoclosure 特性。
func serveAutoclosure(customer customerProvider: @autoclosure () -> String) {
    print("Now serving \(customerProvider())")
}
serveAutoclosure(customer: customersInline.remove(at: 0))
print(customersInline)



//如果你想让一个自动闭包可以“逃逸”，则应该同时使用 @autoclosure 和 @escaping 属性。
var customerProviders: [() -> String] = []
func collectCustomerProviders(_ customerProvider: @autoclosure @escaping () -> String) {
    customerProviders.append(customerProvider)
}

collectCustomerProviders(customersInline.remove(at: 0))
collectCustomerProviders(customersInline.remove(at: 0))

print(customersInline)
for customerProvider in customerProviders {
    print("Now serving \(customerProvider())")
}
print(customersInline.count)
