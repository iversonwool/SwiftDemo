//
//  FilePrivate.swift
//  25.AccessControl
//
//  Created by LeeHow on 2018/10/24.
//  Copyright © 2018 LeeHow. All rights reserved.
//

import Foundation

private struct PrivateStruct {
    let name = "private struct"
    
}


struct TestStruct {
    fileprivate let privateStructA = PrivateStruct()
    private struct PrivateStructInternal {
        let name = "Private Struct Internal"
        
    }
    private let pA = PrivateStructInternal()
    
}


struct testStructB {
//    let pB = PrivateStructInternal()
    
}

