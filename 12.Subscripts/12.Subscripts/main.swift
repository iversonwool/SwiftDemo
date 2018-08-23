//
//  main.swift
//  12.Subscripts
//
//  Created by LeeHow on 2018/8/22.
//  Copyright © 2018 LeeHow. All rights reserved.
//

import Foundation

print("Hello, World!")




struct TimesTable {
    let multiplier: Int
    subscript(index: Int) -> Int {
        return multiplier * index
    }
}

let three = TimesTable(multiplier: 3)
print(three[6])



struct Matrix {
    let rows: Int, columns: Int
    var grid: [Double]
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        grid = Array(repeating: 0.0, count: rows * columns)
    }
    func indexIsValid(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    subscript(row: Int, column: Int) -> Double {
        get {
            assert(indexIsValid(row: row, column: column), "Index out of Range")
            return grid[row * columns + column]
        }
        set {
            assert(indexIsValid(row: row, column: column), "Index out of Range")
            grid[row * columns + column] = newValue
        }
    }
}


var matrix = Matrix(rows: 2, columns: 2)

matrix[0, 1] = 8.9
matrix[1, 0] = 3.4


print(matrix[1, 0])














