//
//  main.swift
//  23.AutoReferenceCounting
//
//  Created by LeeHow on 2018/8/28.
//  Copyright © 2018 LeeHow. All rights reserved.
//

import Foundation

print("Hello, World!")



class Person {
    let name: String
    init(name: String) {
        self.name = name
        print("\(name) is being initialized")
    }
    var apartment: Apartment?
    
    deinit {
        print("\(name) is being deintialized")
    }
}



class Apartment {
    let unit: String
    init(unit: String) {
        self.unit = unit
    }
    //weak
    //打破了强引用
    weak var tenant: Person?
    deinit {
        print("Apartment \(unit) is being deinitialized")
    }
}

var reference1: Person?
var reference2: Person?
var reference3: Person?



reference1 = Person(name: "Jhon")
reference2 = reference1
reference3 = reference1


reference1 = nil
reference2 = nil

reference3 = nil
//deinitialized


//如果两个类实例互相持有对方的强引用，因而每个实例都让对方一直存在，就是这种情况。
//这就是所谓的循环强引用。




var john: Person?
var unit4A: Apartment?


john = Person(name: "Jhon")
unit4A = Apartment(unit: "4A")

john!.apartment = unit4A
unit4A!.tenant = john

john = nil
unit4A = nil

//////////////////////////////////////
//warning 两个实例并没有被deinitialized//
//warning 两个实例并没有被deinitialized//
//warning 两个实例并没有被deinitialized//
//////////////////////////////////////



//解决之法
//two ways
//weak reference
//unowned reference



//
//注意
//
//当 ARC 设置弱引用为 nil 时，属性观察不会被触发。


//注意
//
//在使用垃圾收集的系统里，弱指针有时用来实现简单的缓冲机制，因为没有强引用的对象只会在内存压力触发垃圾收集时才被销毁。
//但是在 ARC 中，一旦值的最后一个强引用被移除，就会被立即销毁，这导致弱引用并不适合上面的用途。

//

class Customer {
    let name: String
    var card: CreditCard?
    init(name: String) {
        self.name = name
    }
    deinit {
        print("\(name) is being deintialized")
    }
}

class CreditCard {
    let number: UInt64
    unowned let customer: Customer
    init(number: UInt64, customer: Customer) {
        self.number = number
        self.customer = customer
    }
    deinit {
        print("Card #\(number) is being deintialized")
    }
}

//
//注意
//
//CreditCard 类的 number 属性被定义为 UInt64 类型而不是 Int 类型，
//以确保 number 属性的存储量在 32 位和 64 位系统上都能足够容纳 16 位的卡号。
//


print("-----------------------------------------")


var customerJhon: Customer?

customerJhon = Customer(name: "Jhon Appleseed")
customerJhon!.card = CreditCard(number: 1234_5678_9012_3456, customer: customerJhon!)



customerJhon = nil
//
//注意 上面的例子展示了如何使用安全的无主引用。
//对于需要禁用运行时的安全检查的情况（例如，出于性能方面的原因），Swift 还提供了不安全的无主引用。
//与所有不安全的操作一样，你需要负责检查代码以确保其安全性。
//你可以通过 unowned(unsafe) 来声明不安全无主引用。
//如果你试图在实例被销毁后，访问该实例的不安全无主引用，你的程序会尝试访问该实例之前所在的内存地址，这是一个不安全的操作。
//
//
//Person 和 Apartment 的例子展示了两个属性的值都允许为 nil，并会潜在的产生循环强引用。
//这种场景最适合用弱引用来解决。
//
//Customer 和 CreditCard 的例子展示了一个属性的值允许为 nil，而另一个属性的值不允许为 nil，这也可能会产生循环强引用。
//这种场景最适合通过无主引用来解决。


//然而，存在着第三种场景，在这种场景中，两个属性都必须有值，并且初始化完成后永远不会为 nil。
//在这种场景中，需要一个类使用无主属性，而另外一个类使用隐式解析可选属性。
class Country {
    let name: String
    var capitalCity: City!
    init(name: String, capitalName: String) {
        self.name = name
        self.capitalCity = City(name: capitalName, country: self)
    }
}


class City {
    let name: String
    unowned let country: Country
    init(name: String, country: Country) {
        self.name    = name
        self.country = country
    }
}

var country = Country(name: "Canada", capitalName: "Ottawa")
print("\(country.name)'s capital city is called \(country.capitalCity.name)")







//闭包的循环强引用


//循环强引用还会发生在当你将一个闭包赋值给类实例的某个属性，并且这个闭包体中又使用了这个类实例时。
//
//这个闭包体中可能访问了实例的某个属性，例如 self.someProperty，或者闭包中调用了实例的某个方法，例如 self.someMethod()。
//这两种情况都导致了闭包“捕获”self，从而产生了循环强引用。

//循环强引用的产生，是因为闭包和类相似，都是引用类型。
//闭包捕获列表（closure capture list）

//如何产生

class HTMLElement {
    let name: String
    let text: String?
    lazy var asHTML: () -> String = {
        [unowned self] in
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name) />"
        }
    }
    init(name: String, text: String? = nil) {//这里加上= nil 之后 init方法会有两个 带text的方法 和不带text的方法
        self.name = name
        self.text = text
    }
    deinit {
        print("\(name) is being deintialized")
    }
}



let heading = HTMLElement(name: "h1")
let defaultText = "some default text"
heading.asHTML = {
    return "<\(heading.name)>\(heading.text ?? defaultText)</\(heading.name)>"
}

print(heading.asHTML())

var paragraph: HTMLElement? = HTMLElement(name: "p", text: "hello, world!")

print(paragraph!.asHTML())


//注意
//
//虽然闭包多次使用了 self，它只捕获 HTMLElement 实例的一个强引用。


paragraph = nil
//注意，HTMLElement 的析构函数中的消息并没有被打印，证明了 HTMLElement 实例并没有被销毁。

//注意
//
//Swift 有如下要求：
//只要在闭包内使用 self 的成员，就要用 self.someProperty 或者 self.someMethod()（而不只是 someProperty 或 someMethod()）。
//这提醒你可能会一不小心就捕获了 self。


//定义捕获列表
//解决循环引用





//在闭包和捕获的实例总是互相引用并且总是同时销毁时，将闭包内的捕获定义为 无主引用。
//
//相反的，在被捕获的引用可能会变为 nil 时，将闭包内的捕获定义为 弱引用。
//弱引用总是可选类型，并且当引用的实例被销毁后，弱引用的值会自动置为 nil。
//这使我们可以在闭包体内检查它们是否存在。
//
//注意
//
//如果被捕获的引用绝对不会变为 nil，应该用无主引用，而不是弱引用。
//
//












