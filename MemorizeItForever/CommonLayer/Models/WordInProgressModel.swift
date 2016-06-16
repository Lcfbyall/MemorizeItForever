//
//  WordInProgress.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 3/21/16.
//  Copyright © 2016 SomeSimpleSolution. All rights reserved.
//

import UIKit

struct WordInProgressModel: MemorizeItModelProtocol {
    var word: WordModel?
    var date: NSDate?
    var column: Int?
    var wordInProgressId: NSUUID?
}

func ==(lhs: WordInProgressModel, rhs: WordInProgressModel) -> Bool {
    return lhs.wordInProgressId == rhs.wordInProgressId
}