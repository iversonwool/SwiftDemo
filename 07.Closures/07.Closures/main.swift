//
//  main.swift
//  07.Closures
//
//  Created by LeeHow on 2018/8/21.
//  Copyright © 2018 LeeHow. All rights reserved.
//

import Foundation

print("Hello, World!")




let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]

var reversed = names.sorted { (s1, s2) -> Bool in
    s1 > s2
}

print(reversed)
//names.sorted { (<#String#>, <#String#>) -> Bool in
//    <#code#>
//}

reversed = names.sorted()
print(reversed)



reversed = names.sorted() { s1, s2 in
    s1 > s2
}

// 尾随闭包
//注意： 如果函数只需要闭包表达式一个参数，当您使用尾随闭包时，您甚至可以把()省略掉。
reversed = names.sorted { s1, s2 in
    s1 > s2
}

print(reversed)


reversed = names.sorted(by: {
    $0 > $1
})
print(reversed)


reversed = names.sorted(by: >)

print(reversed)



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



