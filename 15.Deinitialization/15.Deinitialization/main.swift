//
//  main.swift
//  15.Deinitialization
//
//  Created by LeeHow on 2018/8/23.
//  Copyright © 2018 LeeHow. All rights reserved.
//

import Foundation

print("Hello, World!")



class Bank {
    static var coinsInBank = 10_000
    static func distribute(coins numberOfCoinsRequested: Int) -> Int {
        let numberOfCoinsToVend = min(numberOfCoinsRequested, coinsInBank)
        coinsInBank -= numberOfCoinsToVend
        return numberOfCoinsToVend
    }
    static func receive(coins: Int) {
        coinsInBank += coins
    }
}


class Player {
    var coinsInPurse: Int
    init(coins: Int) {
        coinsInPurse = Bank.distribute(coins: coins)
    }
    func win(coins: Int) {
        coinsInPurse += Bank.distribute(coins: coins)
    }
    deinit {
        Bank.receive(coins: coinsInPurse)
    }
}
//
//
//这个 Player 实例存储在一个名为 playerOne 的可选类型的变量中。
//这里使用了一个可选类型的变量，因为玩家可以随时离开游戏，设置为可选使你可以追踪玩家当前是否在游戏中。
//是为了将来有可能离开游戏把playerOne设置为nil
//仅仅只是声明为可选 而不是代表调用Player(coins: 100)会失败
var playerOne: Player? = Player(coins: 100)


playerOne!.win(coins: 2_000)
print(playerOne!.coinsInPurse)
print(Bank.coinsInBank)



playerOne = nil
print("playOne has left the game")
print(Bank.coinsInBank)
// 数量恢复到10000











