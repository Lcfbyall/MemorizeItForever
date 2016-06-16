//
//  ManageHelper.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 5/1/16.
//  Copyright © 2016 SomeSimpleSolution. All rights reserved.
//

import Foundation
import BaseDataAccess
@testable import MemorizeItForever

class FlowHelper {
    func NewSetModel(initialContext: ManagedObjectContextProtocol) -> SetModel?{
        let fakeSetDataAccess = FakeSetDataAccess(initialContext: initialContext)
        var setModel = SetModel()
        setModel.name = "Default"
        do{
            try fakeSetDataAccess.saveSetEntity(setModel)
            return try fakeSetDataAccess.fetchSets()[0]
        }
        catch{
            return nil
        }
    }
    
    func NewWordModel(initialContext: ManagedObjectContextProtocol) -> WordModel?{
        let fakeWordDataAccess = FakeWordDataAccess(initialContext: initialContext)
        var wordModel = WordModel()
        wordModel.meaning = "Book"
        wordModel.phrase = "Livre"
        wordModel.setId = NewSetModel(initialContext)?.setId
        do{
            try fakeWordDataAccess.saveWordEntity(wordModel)
            let words = try fakeWordDataAccess.fetchWords()
            return words[words.count - 1]
        }
        catch{
            return nil
        }

    }
}