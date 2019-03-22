//
//  main.swift
//  08.Enumerations
//
//  Created by LeeHow on 2018/8/21.
//  Copyright © 2018 LeeHow. All rights reserved.
//

import Foundation

print("Hello, World!")


// 枚举
//枚举为**一组相关的值**定义了一个**共同的类型**，使你可以在你的代码中以**类型安全**的方式来使用这些值。
//Swift 中的枚举更加灵活，不必给每一个枚举成员提供一个值。
//如果给枚举成员提供一个值（称为“原始”值），则该值的类型可以是**字符串**、**字符**，或是一个**整型值**或**浮点数**。
//关联值
//在 Swift 中，枚举类型是一等（first-class）类型。

//MARK: - 枚举语法



//MARK: - 关联值
enum Barcode {
    case upc(Int, Int, Int, Int)
    case qrCode(String)
}

var productBarcode = Barcode.upc(1, 111, 333, 3)

productBarcode = .qrCode("NHHFDCHHJVVBJJKJ")


//MARK: - 使用Switch语句匹配枚举值
switch productBarcode {
case .upc(let x, let y, let z, let a):
    print("UPC: \(x) \(y) \(z) \(a)")
case .qrCode(let string):
    print("qrCode: \(string)")
}

//强制穷举
//当不需要匹配每个枚举成员的时候，你可以提供一个 default 分支来涵盖所有未明确处理的枚举成员：


//如果一个枚举成员的所有关联值都被提取为常量，或者都被提取为变量，为了简洁，你可以只在成员名称前标注一个 let 或者 var：

switch productBarcode {
case let .upc(x, y, z, a):
    print("UPC: \(x) \(y) \(z) \(a)")
case let .qrCode(string):
    print("qrCode: \(string)")
}

//多个成员值可以出现在同一行上，用逗号隔开：
enum Planet: Int {
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
}

//MARK: - 枚举成员的遍历


//令枚举遵循 CaseIterable 协议。
//Swift 会生成一个 allCases 属性，用于表示一个包含枚举所有成员的集合。
enum Beverage: CaseIterable {
    case coffee, tea, juice
}

for item in Beverage.allCases {
    print(item)
}


//MARK: - 原始值
//作为关联值的替代选择，枚举成员可以被默认值（称为原始值）预填充，这些原始值的类型**必须相同**。

enum ASCIIControlCharacter: Character {
    case tab = "\t"
    case lineFeed = "\n"
    case carriageReturn = "\r"
}

//MARK : - 原始值的隐式赋值
//例如，当使用整数作为原始值时，隐式赋值的值依次递增 1。

enum Week: Int {
    case monday = 1
    case tuesday = 2
}


//当使用字符串作为枚举类型的原始值时，每个枚举成员的隐式原始值为该枚举成员的名称。

enum WeekName: String {
    case Monday
    case Tuesday
}

print(WeekName.Monday.rawValue)


//MARK: - 使用原始值初始化枚举实例
//如果在定义枚举类型的时候使用了原始值，那么将会自动获得一个初始化方法，
//这个方法接收一个叫做 rawValue 的参数，参数类型即为原始值类型，返回值则是枚举成员或 nil。

let week = Week(rawValue: 2)


//week 是 Week?类型


//MARK: - 递归枚举
//递归枚举是一种枚举类型，它有一个或多个枚举成员使用该枚举类型的实例作为关联值
