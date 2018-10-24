//
//  FileA.swift
//  25.AccessControl
//
//  Created by LeeHow on 2018/10/24.
//  Copyright © 2018 LeeHow. All rights reserved.
//

import Foundation

fileprivate struct FileprivateStruct {
    let name = "fileprivate property"
    fileprivate let clsA: SomeFilePrivateClass = {
        let temp = SomeFilePrivateClass()
        temp.someFilePrivateMethod() // 只能调用fileprivate方法 不能调用private方法
        return temp
    }()
    
}

struct TestStructC {
    fileprivate let pC = FileprivateStruct()
    
}

fileprivate class SomeFilePrivateClass {        // 显式 fileprivate 类
    func someFilePrivateMethod() {
        somePrivateMethod()
    }              // 隐式 fileprivate 类成员
    private func somePrivateMethod() {}          // 显式 private 类成员
}

//fileprivate let clsA = SomeFilePrivateClass()
//clsA.someFilePrivateMethod()
