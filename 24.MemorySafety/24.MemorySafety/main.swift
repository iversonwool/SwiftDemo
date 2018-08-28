//
//  main.swift
//  24.MemorySafety
//
//  Created by LeeHow on 2018/8/28.
//  Copyright © 2018 LeeHow. All rights reserved.
//

import Foundation

print("Hello, World!")


//
//
//特别是，当你有两个访问符合下列的情况：
//
//至少有一个是写访问
//它们访问的是同一个存储地址
//它们的访问在时间线上部分重叠

//长期写访问


//In-Out参数的访问冲突
//1.

var stepSize = 1



//注意
//
//因为操作符也是函数，它们也会对 in-out 参数进行长期访问。
//例如，假设 balance(_:_:) 是一个名为 <^> 的操作符函数，
//那么 playerOneScore <^> playerOneScore 也会造成像 balance(&playerOneScore, &playerOneScore) 一样的冲突。



//方法里的self访问冲突

//mutating
func balance(_ x: inout Int, _ y: inout Int) {
    let sum = x + y
    x = sum / 2
    y = sum - x
}

struct Player {
    var name: String
    var health: Int
    var energy: Int
    static let maxHealth = 10
    mutating func restoreHealth() {
        health = Player.maxHealth
    }
}
extension Player {
    mutating func shareHealth(with teammate: inout Player) {
        balance(&teammate.health, &health)
    }
}

var oscar = Player(name: "Oscar", health: 10, energy: 10)
var maria = Player(name: "Maria", health: 5, energy: 10)

oscar.shareHealth(with: &maria)
print(oscar.health, maria.health)

//oscar.shareHealth(with: &oscar)
//// 错误：oscar 访问冲突

//mutating 方法在调用期间需要对 self 发起写访问，而同时 in-out 参数也需要写访问。


//属性的访问冲突

//
//如结构体，元组和枚举的类型都是由多个独立的值组成的，例如结构体的属性或元组的元素。
//因为它们都是值类型，修改值的任何一部分都是对于整个值的修改，意味着其中一个属性的读或写访问都需要访问整一个值。
//例如，元组元素的写访问重叠会产生冲突：
//
//
//
//var playerInformation = (health: 10, energy: 10)
//balance(&playerInformation.health, &playerInformation.energy)
//运行时错误

//
//特别是当你遵循下面的原则时，它可以保证结构体属性的重叠访问是安全的：
//
//你访问的是实例的存储属性，而不是计算属性或类的属性
//结构体是本地变量的值，而非全局变量
//结构体要么没有被闭包捕获，要么只被非逃逸闭包捕获了
//















