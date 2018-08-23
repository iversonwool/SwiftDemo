//
//  main.swift
//  06.Functions
//
//  Created by LeeHow on 2018/8/21.
//  Copyright © 2018 LeeHow. All rights reserved.
//

import Foundation

print("Hello, World!")


func printWithoutCounting(stringToPrint: String) -> Int {
    print(stringToPrint)
    return stringToPrint.count
}


let _ = printWithoutCounting(stringToPrint: "Hello")
print(printWithoutCounting(stringToPrint: "Hello"))


// inout Parameter
var someInt = 3
var anotherInt = 107
func swapTwoInts(_ a: inout Int, _ b: inout Int) {
    let temporary = a
    a = b
    b = temporary
}

swap(&someInt, &anotherInt)
print(someInt, anotherInt)


func addTwoInts(a: Int, b: Int) -> Int {
    return a + b
}

func multiplyTwoInts(_ a: Int, _ b: Int) -> Int {
    return a * b
}

var mathFunc: (Int, Int) -> Int = addTwoInts

print(mathFunc(1, 2))

mathFunc = multiplyTwoInts(_:_:)

print(mathFunc(3, 8))


func printMathResult(mathFunction: (Int, Int) -> Int, a: Int, b: Int) {
    print("result is \(mathFunction(a, b))")
}

printMathResult(mathFunction: addTwoInts, a: 5, b: 90)


func stepForward(input: Int) -> Int {
    return input + 1
}

func stepBackward(input: Int) -> Int {
    return input - 1
}


func choseStepFunction(backwards: Bool) -> (Int) -> Int {
    // nested
    func stepForward(input: Int) -> Int {
        return input + 1
    }
    
    func stepBackward(input: Int) -> Int {
        return input - 1
    }
    return backwards ? stepBackward : stepForward
}

var currentValue = 3
let moveNearerToZero  = choseStepFunction(backwards: currentValue > 0)
while currentValue != 0 {
    print(currentValue)
    currentValue = choseStepFunction(backwards: currentValue > 0)(currentValue)
}
//exit(0)
print("Zero")








