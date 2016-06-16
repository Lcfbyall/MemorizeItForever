//
//  WordManager.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 5/1/16.
//  Copyright © 2016 SomeSimpleSolution. All rights reserved.
//

import Foundation

class WordManager {
    
    private var _dataAccess: WordDataAccess?
    private var wordDataAccess: WordDataAccess{
        guard let dataAccess = _dataAccess else{
            _dataAccess = WordDataAccess()
            return _dataAccess!
        }
        return dataAccess
    }
    
    private var _wodInProgressDataAccess: WordInProgressDataAccess?
    private var wordInProgressDataAccess: WordInProgressDataAccess{
        guard let inProgressDataAccess = _wodInProgressDataAccess else{
            _wodInProgressDataAccess = WordInProgressDataAccess()
            return _wodInProgressDataAccess!
        }
        return inProgressDataAccess
    }
    
    private var _wodHistoryDataAccess: WordHistoryDataAccess?
    private var wordHistoryDataAccess: WordHistoryDataAccess{
        guard let historyDataAccess = _wodHistoryDataAccess else{
            _wodHistoryDataAccess = WordHistoryDataAccess()
            return _wodHistoryDataAccess!
        }
        return historyDataAccess
    }
    
    init(){
        _dataAccess = nil
        _wodInProgressDataAccess = nil
        _wodHistoryDataAccess = nil
    }
    
    init(dataAccess: WordDataAccess, wordInProgressDataAccess: WordInProgressDataAccess?, wodHistoryDataAccess: WordHistoryDataAccess?){
        _dataAccess = dataAccess
        _wodInProgressDataAccess = wordInProgressDataAccess
        _wodHistoryDataAccess = wodHistoryDataAccess
    }
    
    func saveWord(phrase: String, meaninig: String, setId: NSUUID){
        do{
            var word = WordModel()
            word.phrase = phrase
            word.meaning = meaninig
            word.setId = setId
            try wordDataAccess.saveWordEntity(word)
        }
        catch{
            
        }
    }
    func editWord(wordModel: WordModel, phrase: String, meaninig: String){
        do{
            var word = WordModel()
            word.phrase = phrase
            word.meaning = meaninig
            word.status = wordModel.status
            word.order = wordModel.order
            word.setId = wordModel.setId
            word.wordId = wordModel.wordId
            try wordDataAccess.editWordEntity(word)
        }
        catch{
            
        }
    }
    
    func deleteWord(wordModel: WordModel){
        do{
            try wordDataAccess.deleteWordEntity(wordModel)
        }
        catch{
            
        }
    }
    
    func putWordInPreColumn(wordModel: WordModel) throws{
        var inProgressModel = WordInProgressModel()
        inProgressModel.column = MemorizeColumns.pre.rawValue
        inProgressModel.date = NSDate().addDay(MemorizeColumns.pre.days)
        inProgressModel.word = wordModel
        do {
            try wordInProgressDataAccess.saveWordInProgressEntity(inProgressModel)
        }
        catch{
            throw error
        }
    }
    
    func answerCorrectly(wordInProgressModel: WordInProgressModel){
        if wordInProgressModel.column == MemorizeColumns.fifth.rawValue{
            do{
                try endOfProgress(wordInProgressModel)
            }
            catch{
                
            }
        }
        else{
            do{
                try progressWord(wordInProgressModel)
            }
            catch{
                
            }
        }
    }
    
    func answerWrongly(wordInProgressModel: WordInProgressModel){
        do{
            try registerInWordHistory(wordInProgressModel)
            try rePutWordInPreColumn(wordInProgressModel)
        }
        catch{
            
        }
    }
    
    func fetchNewWordsToPutInPreColumn() throws{
        guard let count = NSUserDefaults.standardUserDefaults().objectForKey(Settings.NewWordsCount.rawValue) as? Int else{
            throw WordManagementFlowError.NewWordsCount("Can not specify new words count")
        }
        do{
            if try allowPutWordsInPreColumn(){
                let words = try wordDataAccess.fetchWordsNotStartedStatus(fetchLimit: count)
                for word in words{
                    try putWordInPreColumn(word)
                    try changeWordStatus(word, wordStatus: .InProgress)
                }
            }
        }
        catch{
            throw error
        }
    }
    
    func fetchWordsForReview() throws -> [WordModel]{
        do{
            var wordInProgress = WordInProgressModel()
            wordInProgress.date = NSDate().addDay(1)
            wordInProgress.column = MemorizeColumns.pre.rawValue
            let wordInProgressList = try wordInProgressDataAccess.fetchWordInProgressByDateAndColumn(wordInProgress)
            var words: [WordModel] = []
            for inProgress in wordInProgressList{
                if let word = inProgress.word{
                    words.append(word)
                }
            }
            return words
        }
        catch{
            throw error
        }
    }
    
    func fetchWordsToExamin() throws -> [WordInProgressModel]{
        // it should fetch words for today and all words that belongs to past
        do{
            var wordInProgress = WordInProgressModel()
            wordInProgress.date = NSDate()
            var wordInProgressList = try wordInProgressDataAccess.fetchWordInProgressByDateAndOlder(wordInProgress)
            wordInProgressList.sortInPlace{$0.column > $1.column}
            return wordInProgressList
        }
        catch{
            throw error
        }
    }
    
    private func allowPutWordsInPreColumn() throws -> Bool{
        do{
            let word = try wordDataAccess.fetchLastWord(.InProgress)
            if word == nil {
                return true
            }
            else{
                var wordHistoryModel = WordHistoryModel()
                wordHistoryModel.word = word
                
                if try wordHistoryDataAccess.countWordHistoryByWordId(wordHistoryModel) > 0{
                    return true
                }
                var wordInProgressModel = WordInProgressModel()
                wordInProgressModel.word = word
                if let wordInProgress = try wordInProgressDataAccess.fetchWordInProgressByWordId(wordInProgressModel){
                    return wordInProgress.column != MemorizeColumns.pre.rawValue
                }
                else{
                    throw WordManagementFlowError.WordInProgressIsNull("Thwre id no word assigned to WordInProgress")
                }
            }
        }
        catch{
            throw error
        }
    }
    
    private func rePutWordInPreColumn(let wordInProgressModel: WordInProgressModel) throws{
        var inProgressModel = WordInProgressModel()
        inProgressModel.column = MemorizeColumns.pre.rawValue
        inProgressModel.date = NSDate().addDay(MemorizeColumns.pre.days)
        inProgressModel.word = wordInProgressModel.word
        inProgressModel.wordInProgressId = wordInProgressModel.wordInProgressId
        do {
            try wordInProgressDataAccess.editWordInProgressEntity(inProgressModel)
        }
        catch{
            throw error
        }
    }
    
    private func registerInWordHistory(wordInProgressModel: WordInProgressModel) throws{
        var wordHistory = WordHistoryModel()
        wordHistory.columnNo = wordInProgressModel.column
        wordHistory.word = wordInProgressModel.word
        do{
            try wordHistoryDataAccess.saveOrUpdateWordHistoryEntity(wordHistory)
        }
        catch{
            throw error
        }
    }
    
    private func endOfProgress(wordInProgressModel: WordInProgressModel) throws{
        guard let word = wordInProgressModel.word else{
            throw WordManagementFlowError.WordModelIsNull("in moveFromProgress")
        }
        do{
            try changeWordStatus(word, wordStatus: .Done)
            try deleteWordInProgress(wordInProgressModel)
        }
        catch let error as NSError {
            throw error
        }
    }
    
    private func deleteWordInProgress(wordInProgressModel: WordInProgressModel) throws{
        do{
            try wordInProgressDataAccess.deleteWordInProgressEntity(wordInProgressModel)
        }
        catch let error as NSError{
            throw error
        }
    }
    
    private func changeWordStatus(wordModel: WordModel, wordStatus: WordStatus) throws{
        do{
            var word = WordModel()
            word.phrase = wordModel.phrase
            word.meaning = wordModel.meaning
            word.status = wordStatus.rawValue
            word.order = wordModel.order
            word.setId = wordModel.setId
            word.wordId = wordModel.wordId
            try wordDataAccess.editWordEntity(word)
        }
        catch let error as NSError{
            throw error
        }
    }
    
    private func progressWord(wordInProgressModel: WordInProgressModel) throws{
        if let column = wordInProgressModel.column{
            let nextStep = findNextStep(column)
            var newWordInProgressModel = WordInProgressModel()
            newWordInProgressModel.column = nextStep.rawValue
            newWordInProgressModel.date = NSDate().addDay(nextStep.days)
            newWordInProgressModel.word = wordInProgressModel.word
            newWordInProgressModel.wordInProgressId = wordInProgressModel.wordInProgressId
            do{
                try wordInProgressDataAccess.editWordInProgressEntity(newWordInProgressModel)
            }
            catch let error as NSError{
                throw WordManagementFlowError.ProgressWord(error.localizedDescription)
            }
        }
        else{
            throw WordManagementFlowError.ProgressWord("column property is null")
        }
    }
    
    private func findNextStep(memorizeColumns: Int) -> MemorizeColumns{
        switch memorizeColumns {
        case MemorizeColumns.pre.rawValue:
            return MemorizeColumns.first
        case MemorizeColumns.first.rawValue:
            return MemorizeColumns.second
        case MemorizeColumns.second.rawValue:
            return MemorizeColumns.third
        case MemorizeColumns.third.rawValue:
            return MemorizeColumns.fourth
        case MemorizeColumns.fourth.rawValue:
            return MemorizeColumns.fifth
        default:
            return MemorizeColumns.pre
        }
    }
    
}