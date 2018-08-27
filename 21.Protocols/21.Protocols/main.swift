//
//  main.swift
//  21.Protocols
//
//  Created by 李浩 on 2018/8/26.
//  Copyright © 2018 李浩. All rights reserved.
//

import Foundation

print("Hello, World!")

protocol SomeProtocol {
    //definition
    var mustBeSettable: Int {
        get
        set
    }
    static func someTypeMethod()
}


protocol FirstProtocol {
    //
}


struct SomeStructure: SomeProtocol {
    //definition
    var mustBeSettable: Int
    static func someTypeMethod() {
        //
    }
}

class SomeSuperClass {
    //
}

class SomeClass: SomeSuperClass, FirstProtocol {
    //
    
}


protocol FullyNamed {
    var fullName: String { get }
}

struct Person: FullyNamed {
    var fullName: String
    
}
let john = Person(fullName: "Jhon")





class Starship: FullyNamed {
    var prefix: String?
    var name: String
    init(name: String, prefix: String? = nil) {
        self.name = name
        self.prefix = prefix
    }
    var fullName: String {
        return (prefix != nil ? prefix! + " " : "") + name
    }
    
}

var ncc1710 = Starship(name: "Enterprise", prefix: "USS")
print(ncc1710.fullName)





protocol RandomNumberGenerator {
    func random() -> Double
}

class LinearCongruentialGenerator: RandomNumberGenerator {
    var lastRandom = 42.0
    let m = 139968.0
    let a = 3877.0
    let c = 29573.0
    func random() -> Double {
        lastRandom = (lastRandom * a + c).truncatingRemainder(dividingBy: m) // 对浮点数的取模运算 truncatingRemainder(dividingBy:)
        return lastRandom / m
    }
}


let generator = LinearCongruentialGenerator()
print(generator.random())

print(generator.random())
print(generator.random())


//4.mutating方法要求
//
//注意
//
//实现协议中的 mutating 方法时，若是类类型，则不用写 mutating 关键字。而对于结构体和枚举，则必须写 mutating 关键字。
//

protocol Toggable {
    mutating func toggle()
}

//mutating不能省
enum OnOffSwitch: Toggable {
    case off, on
    mutating func toggle() {
        switch self {
        case .off:
            self = .on
        default:
            self = .off
        }
    }
}

var lightSwitch = OnOffSwitch.off
lightSwitch.toggle()
print(lightSwitch)




//5.构造器要求

protocol InitProtocol {
    init(parameter: Int)
}



class RequiredClass: InitProtocol {
    required init(parameter: Int) {
        //
    }
}

//注意
//
//如果类已经被标记为 final，那么不需要在协议构造器的实现中使用 required 修饰符，因为 final 类不能有子类。关于 final 修饰符的更多内容，请参见防止重写。






//协议作为类型
class Dice {
    let sides: Int
    let generator: RandomNumberGenerator
    init(sides: Int, generator: RandomNumberGenerator) {
        self.sides = sides
        self.generator = generator
    }
    func roll() -> Int {
        return Int(generator.random() * Double(sides)) + 1
    }
}


var d6 = Dice(sides: 6, generator: LinearCongruentialGenerator())

for _ in 1...5 {
    print("Random dice roll is \(d6.roll())")
}


//委托
protocol DiceGame {
    var dice: Dice { get }
    func play()
}

protocol DiceGameDelegate {
    func gameDidStart(_ game: DiceGame)
    func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int)
    func gameDidEnd(_ game: DiceGame)
}


class SnakeAndLadders: DiceGame {
    let finalSquare = 25
    var dice = Dice(sides: 6, generator: LinearCongruentialGenerator())
    var square = 0
    
    var board: [Int]
    init() {
        board = [Int](repeating: 0, count: finalSquare + 1)
        board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
        board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
    }
    var delegate: DiceGameDelegate?
    func play() {
        square = 0
        delegate?.gameDidStart(self)
        gameLoop: while square != finalSquare {
            let diceRoll = dice.roll()
            delegate?.game(self, didStartNewTurnWithDiceRoll: diceRoll)
            switch square + diceRoll {
            case finalSquare:
                break gameLoop
            case let newSquare where newSquare > finalSquare:
                continue gameLoop
            default:
                square += diceRoll
                square += board[square]
            }
        }
        delegate?.gameDidEnd(self)
    }
}


class DiceGameTracker: DiceGameDelegate {
    var numberOfTurns = 0
    func gameDidStart(_ game: DiceGame) {
        numberOfTurns = 0
        if game is SnakeAndLadders {
            print("started a new game of snakes and ladders")
        }
        print("the game is using a \(game.dice.sides)-side dice")
    }
    func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int) {
        numberOfTurns += 1
        print("Rolled a \(diceRoll)")
    }
    func gameDidEnd(_ game: DiceGame) {
        print("the game lasted for \(numberOfTurns) turns")
    }
}



let tracker = DiceGameTracker()
let game = SnakeAndLadders()
game.delegate = tracker
game.play()




protocol TextRepresentable {
    var textualDescription: String {
        get
    }
}

extension Dice: TextRepresentable {
    var textualDescription: String {
        return "A \(sides)-side dice"
    }
}

let d12 = Dice(sides: 12, generator: LinearCongruentialGenerator())
print(d12.textualDescription)

extension SnakeAndLadders: TextRepresentable {
    var textualDescription: String {
        return "A game of Snake and Ladders with \(finalSquare) squares"
    }
}
print(game.textualDescription)




//有条件的遵循协议
extension Array: TextRepresentable where Element: TextRepresentable {
    var textualDescription: String {
        let itemsAsText = self.map { $0.textualDescription }
        return "[" + itemsAsText.joined(separator: ", ") + "]"
    }
}


let myDice = [d6, d12]


print(myDice.textualDescription)








//当一个类型已经符合了某个协议中的所有要求，却还没有声明采纳该协议时，可以通过空扩展体的扩展采纳该协议：


struct Hamster {
    var name: String
    var textualDescription: String {
        return "a hamster named \(name)"
    }
    
}
extension Hamster: TextRepresentable {}



let simonTheHamster = Hamster(name: "Simon")
let somethingTextRepresentable: TextRepresentable = simonTheHamster
print(somethingTextRepresentable.textualDescription)

//注意
//
//即使满足了协议的所有要求，类型也不会自动遵循协议，必须显式地遵循协议。





let things: [TextRepresentable] = [game, d12, simonTheHamster]
for thing in things {
    print(thing.textualDescription)
}





protocol PrettyTextRepresentable: TextRepresentable {
    var prettyTextualDescription: String { get }
}


extension SnakeAndLadders: PrettyTextRepresentable {
    var prettyTextualDescription: String {
        var output = textualDescription + ":\n"
        for index in 1...finalSquare {
            switch board[index] {
            case let ladder where ladder > 0:
                output += "▲ "
            case let snake where snake < 0:
                output += "▼ "
            default:
                output += "○ "
            }
        }
        return output
    }
}



print(game.prettyTextualDescription)




//协议组合
protocol Named {
    var name: String { get }
    
}
protocol Aged {
    var age: Int { get }
    
}
struct PersonXX: Named, Aged {
    var name: String
    var age: Int
}

func wishHappyBirthday(to celebrator: Named & Aged) {
    print("Happy birthday, \(celebrator.name), you're \(celebrator.age)!")
}


let birthdayPerson = PersonXX(name: "Malcom", age: 21)
wishHappyBirthday(to: birthdayPerson)




//检查协议一致性




//可选的协议要求


//可选要求用在你需要和 Objective-C 打交道的代码中。协议和可选要求都必须带上 @objc 属性。
//标记 @objc 特性的协议只能被继承自 Objective-C 类的类或者 @objc 类遵循，其他类以及结构体和枚举均不能遵循这种协议。
@objc protocol CounterDataSource {
    @objc optional func increment(forCount count: Int) -> Int
    @objc optional var fixedIncrement: Int { get }
}
//
//注意
//
//严格来讲，CounterDataSource 协议中的方法和属性都是可选的，因此遵循协议的类可以不实现这些要求，尽管技术上允许这样做，不过最好不要这样写。



class Counter {
    var count = 0
    var dataSource: CounterDataSource?
    func increment() {
        if let amount = dataSource?.increment?(forCount: count) {
            count += amount
        } else if let amount = dataSource?.fixedIncrement {
            count += amount
        }
    }
}


class ThreeSource: NSObject, CounterDataSource {
    let fixedIncrement = 3
}





var counter = Counter()
counter.dataSource = ThreeSource()

for _ in 1...4 {
    counter.increment()
    print(counter.count)
}

class TowardsZeroSource: NSObject, CounterDataSource {
    func increment(forCount count: Int) -> Int {
        if count == 0 {
            return 0
        } else if count < 0 {
            return 1
        } else {
            return -1
        }
    }
}
counter.count = -4
counter.dataSource = TowardsZeroSource()
for _ in 1...5 {
    counter.increment()
    print(counter.count)
}



//协议扩展
extension RandomNumberGenerator {
    func randomBool() -> Bool {
        return random() > 0.5
    }
}

let generator1 = LinearCongruentialGenerator()
print(generator1.randomBool())
print(generator1.randomBool())













