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
    
}


protocol FirstProtocol {
    //
}


struct SomeStructure: SomeProtocol {
    //definition
}

class SomeSuperClass {
    //
}

class SomeClass: SomeSuperClass, FirstProtocol {
    //
    
}













