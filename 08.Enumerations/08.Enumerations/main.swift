//
//  main.swift
//  08.Enumerations
//
//  Created by LeeHow on 2018/8/21.
//  Copyright © 2018 LeeHow. All rights reserved.
//

import Foundation

print("Hello, World!")


// 枚举类型

enum Barcode {
    case upc(Int, Int, Int, Int)
    case qrCode(String)
}

var productBarcode = Barcode.upc(1, 111, 333, 3)

productBarcode = .qrCode("NHHFDCHHJVVBJJKJ")

switch productBarcode {
case .upc(let x, let y, let z, let a):
    print("UPC: \(x) \(y) \(z) \(a)")
case .qrCode(let string):
    print("qrCode: \(string)")
}


switch productBarcode {
case let .upc(x, y, z, a):
    print("UPC: \(x) \(y) \(z) \(a)")
case let .qrCode(string):
    print("qrCode: \(string)")
}


enum Planet: Int {
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
}

// indirect




















