//
//  main.swift
//  DemoClassesAndStructures
//
//  Created by 李浩 on 2018/8/19.
//  Copyright © 2018 李浩. All rights reserved.
//

import Foundation

print("Hello, World!")


// define a structure

struct Resolution {
    //
    var width = 0
    var height = 0
    
}

//define a class
class VedioMode {
    //
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?
    
}

// generate a instace
let someResolution = Resolution()
let someVedioMode = VedioMode()



// access property
print("the width of someResolution is \(someResolution.width)")

print("the width of someVedioMode is \(someVedioMode.resolution.width)")

someVedioMode.resolution.width = 1920

let vga = Resolution(width: 640, height: 960)

//let someVedioMode = VedioMode()


let hd = Resolution(width: 1920, height: 1080)
var cinema = hd
cinema.width = 2048
print("cinema is now \(cinema.width) pixel wide")

print("hd is still \(hd.width) pixle wide")

//print("hd => %p", hd)

enum CompasssPoint {
    case North, South, East, West
}
var currentDirection = CompasssPoint.West
let rememberedDirection = currentDirection
currentDirection = .East
if rememberedDirection == .West {
    print("the remembered direction is still .West")
}

let tenEighty = VedioMode()
tenEighty.resolution = hd
tenEighty.interlaced = true
tenEighty.name = "1080i"
tenEighty.frameRate = 25.0

let alsoTenEighty = tenEighty
alsoTenEighty.frameRate = 30.0
print("the frameRate property of tenEighty is now \(tenEighty.frameRate)")

// constant
//tenEighty = VedioMode()

if tenEighty === alsoTenEighty {
    print("tenEighty is equal to alsoTenEighty")
}



var ages = ["Peter": 23, "Wei": 35, "Anish": 65, "Katya": 19]
var copiedAges = ages

copiedAges["Peter"] = 24
if let peterAge = ages["Peter"] {
    print(peterAge)
}

var a = [1, 2, 3]
var b = a
var c = a

print(a[0])
print(b[0])
print(c[0])



a[0] = 42
print(a[0])
print(b[0])
print(c[0])







