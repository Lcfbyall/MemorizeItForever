//
//  WordArchive.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 3/22/16.
//  Copyright © 2016 SomeSimpleSolution. All rights reserved.
//

import UIKit

struct WordHistoryModel: MemorizeItModelProtocol {
    var word: WordModel?
    var columnNo: Int?
    var failureCount: Int?
    var wordHistoryId: NSUUID?
}

func ==(lhs: WordHistoryModel, rhs: WordHistoryModel) -> Bool {
    return lhs.wordHistoryId == rhs.wordHistoryId
}
