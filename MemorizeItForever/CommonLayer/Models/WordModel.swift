//
//  Word.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 3/21/16.
//  Copyright © 2016 SomeSimpleSolution. All rights reserved.
//

import UIKit

struct WordModel: Equatable, MemorizeItModelProtocol {
    var wordId: NSUUID?
    var phrase: String?
    var meaning: String?
    var order: UInt?
    var setId: NSUUID?
    var status: Int? = WordStatus.NotStarted.rawValue
}

func ==(lhs: WordModel, rhs: WordModel) -> Bool {
    return lhs.wordId == rhs.wordId
}
