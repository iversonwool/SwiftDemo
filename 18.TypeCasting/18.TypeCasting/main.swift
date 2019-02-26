//
//  main.swift
//  18.TypeCasting
//
//  Created by LeeHow on 2018/8/24.
//  Copyright © 2018 LeeHow. All rights reserved.
//

import Foundation

print("Hello, World!")


//MARK: - 为类型转换定义类层次
class MediaItem {
    var name: String
    init(name: String) {
        self.name = name
    }
}

class Movie: MediaItem {
    var director: String
    init(name: String, director: String) {
        self.director = director
        super.init(name: name)
    }
}

class Song: MediaItem {
    var artist: String
    init(name: String, artist: String) {
        self.artist = artist
        super.init(name: name)
    }
}

let library = [
    Movie(name: "Casablanca",              director: "Michael Curtiz"),
    Song( name: "Blue Suede Shoes",        artist: "Elvis Presley"),
    Movie(name: "Citizen Kane",            director: "Orson Welles"),
    Song( name: "The One And Only",        artist: "Chesney Hawkes"),
    Song( name: "Never Gonna Give You Up", artist: "Rick Astley")
]

//MARK: - 检查类型
//用类型检查操作符（is）来检查一个实例是否属于特定子类型。

var movieCount = 0
var songCount = 0
for item in library {
    if item is Movie {
        movieCount += 1
    } else if item is Song {
        songCount += 1
    }
}

print("movie count is \(movieCount)")
print("song count is \(songCount)")

//is  or as   返回一个Bool值
//as? or as!  返回一个Optional

//MARK: - 向下转型
for item in library {
    if let movie = item as? Movie {
        print(movie.director)
    } else if let song = item as? Song {
        print(song.artist)
    }
}

//MARK: - Any和AnyObject的类型转换

//Any 可以表示任何类型，包括函数类型。
//AnyObject 可以表示任何类类型的实例。



var things = [Any]()

things.append(0)
things.append(0.0)
things.append(42)
things.append(3.14159)
things.append("Hello")
things.append((3.0, 5.0))
things.append(Movie(name: "Ghostbusters", director: "Ivan Reitman"))
things.append({ (name: String) -> String in "Hello, \(name)" })



print("=========================分割线=========================")
for thing in things {
    switch thing {
    case 0 as Int:
        print("zero as an Int")
    case 0 as Double:
        print("zero as a Double")
    case let someInt as Int:
        print("an integer value of \(someInt)")
    case let someDouble as Double where someDouble > 0:
        print("a positive double value of \(someDouble)")
    case is Double:
        print("some other double value that I don't want to print")
    case let someString as String:
        print("a string value of \(someString)")
    case let (x, y) as (Double, Double):
        print("an (x, y) point at (\(x), \(y))")
    case let movie as Movie:
        print("a movie called \(movie.name), dir. \(movie.director)")
    case let stringConverter as (String) -> String:
        print(stringConverter("Michael"))
    default:
        print("something else")
    }
}
