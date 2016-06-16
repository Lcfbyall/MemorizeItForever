//
//  Set.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 3/27/16.
//  Copyright © 2016 SomeSimpleSolution. All rights reserved.
//

import UIKit

struct SetModel: MemorizeItModelProtocol {
    var setId: NSUUID?
    var name: String?
}

func ==(lhs: SetModel, rhs: SetModel) -> Bool {
    return lhs.setId == rhs.setId
}