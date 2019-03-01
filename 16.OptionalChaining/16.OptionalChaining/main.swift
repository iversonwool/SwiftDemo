//
//  main.swift
//  16.OptionalChaining
//
//  Created by 李浩 on 2018/8/23.
//  Copyright © 2018 李浩. All rights reserved.
//

import Foundation

print("Hello, World!")




class Person {
    var residence: Residence?
}

class Room {
    let name: String
    init(name: String) {
        self.name = name
    }
}


class Residence {
    var rooms = [Room]()
    
    var numberOfRooms: Int {
        return rooms.count
    }
    subscript(i: Int) -> Room {
        get {
            return rooms[i]
        }
        set {
            rooms[i] = newValue
        }
    }
    func printNumberOfRooms() {
        print("the number of rooms is \(numberOfRooms)")
    }
    var address: Address?
    
}

class Address {
    var buildingName:   String?
    var buildingNumber: String?
    var street:         String?
    func buildingIdentifier() -> String? {
        if let buildingNumber = buildingNumber, let street = street {
            return "\(buildingNumber) \(street)"
        } else if buildingName != nil {
            return buildingName
        } else {
            return nil
        }
    }
}

//MARK: - 使用 可选链式调用 代替 强制展开
let john = Person()
//let roomCount = john.residence!.numberOfRooms
//这会引发运行时错误
//编译没有错误

//john.residence = Residence()

if let roomCount = john.residence?.numberOfRooms {
    print("John's residence has \(roomCount) room(s)")
} else {
    print("Unable to retrieve the number of rooms")
}



//要注意的是，即使 numberOfRooms 是非可选的 Int 时，这一点也成立。
//只要使用可选链式调用就意味着 numberOfRooms 会返回一个 Int? 而不是 Int。





let someAddress = Address()
someAddress.buildingNumber = "29"
someAddress.street = "Acacia Road"
john.residence?.address = someAddress

//验证最后=右边的代码是否被执行
//写一个func
func createAddress() -> Address {
    print("Func was called.")
    let someAddress = Address()
    someAddress.buildingNumber = "29"
    someAddress.street = "Acacia Road"
    return someAddress
}

john.residence?.address = createAddress()


//没有打印Func was called.

//⚠️通过可选链式调用得到的返回值都是可选的。



if john.residence?.printNumberOfRooms() != nil {
     print("It was possible to print the number of rooms.")
} else {
    print("It was not possible to print the number of rooms.")
}


if let firstRoomName = john.residence?[0].name {
    print("The first room name is \(firstRoomName).")
} else {
    print("Unable to retrieve the first room name.")
}

john.residence?[0] = Room(name: "Bathroom")
if let firstRoomName = john.residence?[0].name {
    print("The first room name is \(firstRoomName).")
} else {
    print("Unable to retrieve the first room name.")
}



let johnHouse = Residence()
johnHouse.rooms.append(Room(name: "Living Room"))
johnHouse.rooms.append(Room(name: "Kitchen"))
john.residence = johnHouse

if let firstRoomName = john.residence?[0].name {
    print("The first room name is \(firstRoomName).")
} else {
    print("Unable to retrieve the first room name.")
}

var testScores = [
    "Dave": [86, 87, 89],
    "Bev" : [79, 89, 81], // 加不加逗号都可以
]

testScores["Dave"]?[0] = 91
testScores["Bev"]?[0] += 1
testScores["Brain"]?[0] = 77


print(testScores)

//可以通过连接多个可选链式调用在更深的模型层级中访问属性、方法以及下标。
//然而，多层可选链式调用不会增加返回值的可选层级。
//
//也就是说：
//
//如果你访问的值不是可选的，可选链式调用将会返回可选值。
//如果你访问的值就是可选的，可选链式调用不会让可选返回值变得“更可选”。
//因此：
//
//通过可选链式调用访问一个 Int 值，将会返回 Int?，无论使用了多少层可选链式调用。
//类似的，通过可选链式调用访问 Int? 值，依旧会返回 Int? 值，并不会返回 Int??。


if let jhonStreet = john.residence?.address?.street {
    print("John's street name is \(jhonStreet)")
} else {
    print("Unable to retrieve the address")
}



let johnAddress = Address()
johnAddress.buildingName = "The Larches"
//johnAddress.buildingNumber = "33"
johnAddress.street = "Laurel Street"
john.residence?.address = johnAddress



if let jhonStreet = john.residence?.address?.street {
    print("John's street name is \(jhonStreet)")
} else {
    print("Unable to retrieve the address")
}



if let buildingIdentifier = john.residence?.address?.buildingIdentifier() {
    print("idetifier is \(buildingIdentifier)")
}

if let beginWithThe = john.residence?.address?.buildingIdentifier()?.hasPrefix("The") {
    if beginWithThe {
        print("has prefix The")
    }
}



