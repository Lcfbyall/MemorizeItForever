//
//  WordFlowsTests.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 5/1/16.
//  Copyright © 2016 SomeSimpleSolution. All rights reserved.
//

import XCTest
import BaseDataAccess
@testable import MemorizeItForever

class WordFlowsTests: XCTestCase {
    var wordManager: WordManager?
    var wordDataAccess: WordDataAccess?
    var wordInProgressDataAccess: WordInProgressDataAccess?
    var wordHistoryDataAccess: WordHistoryDataAccess?
    var context: ManagedObjectContextProtocol?
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        context = InMemoryManagedObjectContext()
        wordDataAccess = FakeWordDataAccess(initialContext: context!)
        wordInProgressDataAccess = FakeWordInProgressDataAccess(initialContext: context!)
        wordHistoryDataAccess = FakeWordHistoryDataAccess(initialContext: context!)
        wordManager = WordManager(dataAccess: wordDataAccess!,wordInProgressDataAccess: wordInProgressDataAccess!,wodHistoryDataAccess: wordHistoryDataAccess)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        wordDataAccess = nil
        wordManager = nil
        context = nil
        wordInProgressDataAccess = nil
        wordHistoryDataAccess = nil
    }
    
    func testPutWordInPreColumn(){
        let word  = newWordModel(context!)
        let tomorrow = NSDate().addDay(1)
        do{
            try wordManager!.putWordInPreColumn(word!)
            let wordInProgresses = try wordInProgressDataAccess!.fetchWordInProgress()
            if wordInProgresses.count == 0{
                XCTFail("Should be able to put word in pre column")
            }
            else{
                XCTAssertEqual(wordInProgresses[0].column, 0, "Pre column must be zero")
                XCTAssertEqual(wordInProgresses[0].date!.equalToDateWithoutTime(tomorrow!), true, "Date must be tomorrow")
            }
        }
        catch{
            XCTFail("Should be able to put word in pre column")
        }
    }
    
    func testAnswerCorrectlyPreColumn(){
        let word = newWordModel(context!)
        var inProgressModel = WordInProgressModel()
        inProgressModel.column = 0
        inProgressModel.date = NSDate().addDay(1)
        inProgressModel.word = word
        let TwoDaysLater = NSDate().addDay(2)
        do{
            try wordInProgressDataAccess!.saveWordInProgressEntity(inProgressModel)
            let wordInProgressesModel = try wordInProgressDataAccess!.fetchWordInProgress()[0]
            wordManager!.answerCorrectly(wordInProgressesModel)
            let wordInProgresses = try wordInProgressDataAccess!.fetchWordInProgress()
            XCTAssertEqual(wordInProgresses[0].column, 1, "First column must be 1")
            XCTAssertEqual(wordInProgresses[0].date!.equalToDateWithoutTime(TwoDaysLater!), true, "Date must be the day after tomorrow")
            }
        catch{
            XCTFail("Should be able to put word in first column")
        }
    }
    
    func testAnswerCorrectlyFirstColumn(){
        let word = newWordModel(context!)
        var inProgressModel = WordInProgressModel()
        inProgressModel.column = 1
        inProgressModel.date = NSDate().addDay(2)
        inProgressModel.word = word
        let theOtherDay = NSDate().addDay(4)
        do{
            try wordInProgressDataAccess!.saveWordInProgressEntity(inProgressModel)
            let wordInProgressesModel = try wordInProgressDataAccess!.fetchWordInProgress()[0]
            wordManager!.answerCorrectly(wordInProgressesModel)
            let wordInProgresses = try wordInProgressDataAccess!.fetchWordInProgress()
            XCTAssertEqual(wordInProgresses[0].column, 2, "Second column must be 2")
            XCTAssertEqual(wordInProgresses[0].date!.equalToDateWithoutTime(theOtherDay!), true, "date must be 4 days later")
        }
        catch{
            XCTFail("Should be able to put word in second column")
        }
    }
    
    func testAnswerCorrectlySecondColumn(){
        let word = newWordModel(context!)
        var inProgressModel = WordInProgressModel()
        inProgressModel.column = 2
        inProgressModel.date = NSDate().addDay(4)
        inProgressModel.word = word
        let theOtherDay = NSDate().addDay(8)
        do{
            try wordInProgressDataAccess!.saveWordInProgressEntity(inProgressModel)
            let wordInProgressesModel = try wordInProgressDataAccess!.fetchWordInProgress()[0]
            wordManager!.answerCorrectly(wordInProgressesModel)
            let wordInProgresses = try wordInProgressDataAccess!.fetchWordInProgress()
            XCTAssertEqual(wordInProgresses[0].column, 3, "Third column must be 3")
            XCTAssertEqual(wordInProgresses[0].date!.equalToDateWithoutTime(theOtherDay!), true, "date must be 8 days later")
        }
        catch{
            XCTFail("Should be able to put word in third column")
        }
    }

    func testAnswerCorrectlyThirdColumn(){
        let word = newWordModel(context!)
        var inProgressModel = WordInProgressModel()
        inProgressModel.column = 3
        inProgressModel.date = NSDate().addDay(8)
        inProgressModel.word = word
        let theOtherDay = NSDate().addDay(16)
        do{
            try wordInProgressDataAccess!.saveWordInProgressEntity(inProgressModel)
            let wordInProgressesModel = try wordInProgressDataAccess!.fetchWordInProgress()[0]
            wordManager!.answerCorrectly(wordInProgressesModel)
            let wordInProgresses = try wordInProgressDataAccess!.fetchWordInProgress()
            XCTAssertEqual(wordInProgresses[0].column, 4, "Fourth column must be 4")
            XCTAssertEqual(wordInProgresses[0].date!.equalToDateWithoutTime(theOtherDay!), true, "date must be 16 days later")
        }
        catch{
            XCTFail("Should be able to put word in fourth column")
        }
    }
    
    func testAnswerCorrectlyFourthColumn(){
        let word = newWordModel(context!)
        var inProgressModel = WordInProgressModel()
        inProgressModel.column = 4
        inProgressModel.date = NSDate().addDay(16)
        inProgressModel.word = word
        let theSecondDay = NSDate().addDay(32)
        do{
            try wordInProgressDataAccess!.saveWordInProgressEntity(inProgressModel)
            let wordInProgressesModel = try wordInProgressDataAccess!.fetchWordInProgress()[0]
            wordManager!.answerCorrectly(wordInProgressesModel)
            let wordInProgresses = try wordInProgressDataAccess!.fetchWordInProgress()
            XCTAssertEqual(wordInProgresses[0].column, 5, "Fifth column must be 5")
            XCTAssertEqual(wordInProgresses[0].date!.equalToDateWithoutTime(theSecondDay!), true, "date must be 32 days later")
        }
        catch{
            XCTFail("Should be able to put word in fifth column")
        }
    }
    
    func testAnswerCorrectlyFifthColumn(){
        let word = newWordModel(context!)
        var inProgressModel = WordInProgressModel()
        inProgressModel.column = 5
        inProgressModel.date = NSDate().addDay(32)
        inProgressModel.word = word
        do{
            try wordInProgressDataAccess!.saveWordInProgressEntity(inProgressModel)
            let wordInProgressesModel = try wordInProgressDataAccess!.fetchWordInProgress()[0]
            wordManager!.answerCorrectly(wordInProgressesModel)
            
            let wordInProgresses = try wordInProgressDataAccess!.fetchWordInProgress()
            XCTAssertEqual(wordInProgresses.count, 0, "WordInProgresses entity should delet after answer correctly in fifth column")
            
            let word = try wordDataAccess!.fetchWords()[0]
            XCTAssertEqual(word.status, WordStatus.Done.rawValue, "Status property of word must marked as Done")
        }
        catch{
            XCTFail("Should be able to dismiss word from being in process")
        }
    }
    
    func testAnswerWronglyInMiddleColumns(){
        let word = newWordModel(context!)
        var inProgressModel = WordInProgressModel()
        inProgressModel.column = 4
        inProgressModel.date = NSDate().addDay(16)
        inProgressModel.word = word
        let theSecondDay = NSDate().addDay(1)
        do{
            try wordInProgressDataAccess!.saveWordInProgressEntity(inProgressModel)
            let wordInProgressesModel = try wordInProgressDataAccess!.fetchWordInProgress()[0]
            wordManager!.answerWrongly(wordInProgressesModel)
            let wordInProgresses = try wordInProgressDataAccess!.fetchWordInProgress()
            XCTAssertEqual(wordInProgresses[0].column, 0, "First column must be zero")
            XCTAssertEqual(wordInProgresses[0].date!.equalToDateWithoutTime(theSecondDay!), true, "date must be tomorrow")
            
           var wordHistoryModel = WordHistoryModel()
            wordHistoryModel.word = word
            wordHistoryModel.columnNo = inProgressModel.column
            
            let wordHistory = try wordHistoryDataAccess!.fetchWordHistoryByWordId(wordHistoryModel)
            XCTAssertEqual(wordHistory[0].columnNo, 4, "columnNo must be the given data( here is 4)")
            XCTAssertEqual(wordHistory[0].failureCount, 1, "failureCount must be 1")
        }
        catch{
            XCTFail("Should be able to put word in pre column")
        }
    }
    
    func testAddDayExtension(){
        let now = NSDate(timeIntervalSinceReferenceDate: 0)
        let tomorrow = NSDate(timeIntervalSinceReferenceDate: 60*60*24)
        XCTAssertEqual(now.addDay(1), tomorrow, "AddDay extension should work fine")
    }
    
    func testFetchWordsForPuttingInPreColumn(){
       let newWord = newWordModel(context!)
        do{
           try wordManager!.fetchNewWordsToPutInPreColumn()
            let words = try wordDataAccess?.fetchWords()
            let wordInProgress = try wordInProgressDataAccess?.fetchWordInProgress()
            XCTAssertEqual(words![0].status, WordStatus.InProgress.rawValue, "Word status should mark as inProgress when enters to preColumn")
            XCTAssertEqual(wordInProgress![0].column, 0, "column should be 0 in preColumn")
            XCTAssertEqual(wordInProgress![0].date!.equalToDateWithoutTime(NSDate().addDay(1)!), true, "date mus be equal to tomorrow")
             XCTAssertEqual(wordInProgress![0].word, newWord, "wordInProgress shoud hold word instance")
        }
        catch{
            XCTFail("should be able to fetch words in pre column")
        }
    }
    
    func testDoNotFetchWordsForPuttingInPreColumnIfAlreadyFetched(){
        let newWord = newWordModel(context!)
        do{
            try wordManager!.fetchNewWordsToPutInPreColumn()
            newWordModel(context!)
            try wordManager!.fetchNewWordsToPutInPreColumn()
            
            let words = try wordDataAccess?.fetchWords()
            let wordInProgress = try wordInProgressDataAccess?.fetchWordInProgress()
            
            XCTAssertEqual(words![0].status, WordStatus.InProgress.rawValue, "Word status should mark as inProgress when enters to preColumn")
            XCTAssertEqual(words![1].status, WordStatus.NotStarted.rawValue, "Second word status should mark as NotStarted")
            XCTAssertEqual(wordInProgress!.count, 1, "Just one word should be in progress in this condition")
            XCTAssertEqual(wordInProgress![0].column, 0, "WordInProgress shoud be in pre column")
            XCTAssertEqual(wordInProgress![0].date!.equalToDateWithoutTime(NSDate().addDay(1)!), true, "WordInProgress shoud be examine tomorrow ")
            XCTAssertEqual(wordInProgress![0].word, newWord, "WordInProgress shoud hold word instance")
        }
        catch{
            XCTFail("should be able to fetch words in first column")
        }
    }
    
    func testShouldWordsForPuttingInPreColumnIfAnsweredAlreadyWrongly(){
        newWordModel(context!)
        do{
            try wordManager!.fetchNewWordsToPutInPreColumn()
            let inProgress = try wordInProgressDataAccess?.fetchWordInProgress()[0]
            wordManager?.answerWrongly(inProgress!)
            newWordModel(context!)
            try wordManager!.fetchNewWordsToPutInPreColumn()
            
            let wordInProgress = try wordInProgressDataAccess?.fetchWordInProgress()
            let words = try wordDataAccess?.fetchWords()
            
                  
            XCTAssertEqual(words![0].status, WordStatus.InProgress.rawValue, "Word status should mark as InProgress when enters to preColumn")
            XCTAssertEqual(words![1].status, WordStatus.InProgress.rawValue, "Second word status should mark as NotStarted")
            XCTAssertEqual(wordInProgress!.count, 2, "Just two words should be in progress in this condition")
            XCTAssertEqual(wordInProgress![0].column, 0, "WordInProgress shoud be in pre column")
            XCTAssertEqual(wordInProgress![0].date!.equalToDateWithoutTime(NSDate().addDay(1)!), true, "WordInProgress shoud be examine tomorrow ")
            XCTAssertEqual(wordInProgress![0].word, words![1], "WordInProgress shoud hold word instance")
            
            XCTAssertEqual(wordInProgress![1].column, 0, "WordInProgress shoud be in pre column")
            XCTAssertEqual(wordInProgress![1].date!.equalToDateWithoutTime(NSDate().addDay(1)!), true, "WordInProgress shoud be examine tomorrow ")
            XCTAssertEqual(wordInProgress![1].word, words![0], "WordInProgress shoud hold word instance")
        }
        catch{
            XCTFail("should be able to fetch words in first column")
        }
    }
    
    
    func testWordsShouldPutInPreColumnIfAnsweredAlreadyCorrectly(){
        let firstWordId = newWordModel(context!)?.wordId
        do{
            try wordManager!.fetchNewWordsToPutInPreColumn()
            let inProgress = try wordInProgressDataAccess?.fetchWordInProgress()[0]
            wordManager?.answerCorrectly(inProgress!)
            let secondWordId =  newWordModel(context!)?.wordId
            try wordManager!.fetchNewWordsToPutInPreColumn()
            
            let wordInProgress = try wordInProgressDataAccess?.fetchWordInProgress()
            let words = try wordDataAccess?.fetchWords()
            let firstWord = words?.filter{$0.wordId == firstWordId}[0]
            let secondWord = words?.filter{$0.wordId == secondWordId}[0]
            let firstWordInProgress = wordInProgress?.filter{$0.word == firstWord}[0]
            let secondWordInProgress = wordInProgress?.filter{$0.word == secondWord}[0]
            
           
            
            XCTAssertEqual(firstWord!.status, WordStatus.InProgress.rawValue, "Word status should mark as InProgress when enters to preColumn")
            XCTAssertEqual(secondWord!.status, WordStatus.InProgress.rawValue, "Word status should mark as InProgress when enters to preColumn")
            XCTAssertEqual(wordInProgress!.count, 2, "just two words should be in progress in this condition")
            XCTAssertEqual(firstWordInProgress!.column, 1, "Answered correctly wordInProgress shoud be in First column")
            XCTAssertEqual(firstWordInProgress!.date!.equalToDateWithoutTime(NSDate().addDay(2)!), true, "Answered correctly w shoud be examine the day after tomorrow ")
            XCTAssertEqual(firstWordInProgress!.word, firstWord, "Answered correctly w shoud hold word instance")

            XCTAssertEqual(secondWordInProgress!.column, 0, "WordInProgress shoud be in pre column")
            XCTAssertEqual(secondWordInProgress!.date!.equalToDateWithoutTime(NSDate().addDay(1)!), true, "WordInProgress shoud be examine tomorrow ")
            XCTAssertEqual(secondWordInProgress!.word, secondWord, "WordInProgress shoud hold word instance")
        }
        catch{
            XCTFail("should be able to fetch words in first column")
        }
    }
    
    func testFetchWordsForReview(){
        newWordModel(context!)
        newWordModel(context!)
        do{
            try wordManager!.fetchNewWordsToPutInPreColumn()
            let inProgressList = try wordInProgressDataAccess?.fetchWordInProgress()
            let inProgress1 = inProgressList![0]
            let inProgress2 = inProgressList![1]
            wordManager?.answerCorrectly(inProgress1)
            wordManager?.answerWrongly(inProgress2)
            newWordModel(context!)
            try wordManager!.fetchNewWordsToPutInPreColumn()
            let words = try wordManager!.fetchWordsForReview()
            XCTAssertEqual(words.count, 2, "Should be able to fetch words for review")
        }
        catch{
            XCTFail("Should be able to fetch words for review")
        }
    }
    
    func testFetchWordsToExamine(){
        
        // it should fetch words for today and all words that belongs to past
        
        let word1 = newWordModel(context!)
        let word2 = newWordModel(context!)
        let word3 = newWordModel(context!)
        let word4 = newWordModel(context!)
        let word5 = newWordModel(context!)
        do{
            var inProgressModel1 = WordInProgressModel()
            inProgressModel1.column = 4
            inProgressModel1.date = NSDate()
            inProgressModel1.word = word1
            try wordInProgressDataAccess?.saveWordInProgressEntity(inProgressModel1)
            
            var inProgressModel2 = WordInProgressModel()
            inProgressModel2.column = 3
            inProgressModel2.date = NSDate()
            inProgressModel2.word = word2
            try wordInProgressDataAccess?.saveWordInProgressEntity(inProgressModel2)
            
            var inProgressModel3 = WordInProgressModel()
            inProgressModel3.column = 1
            inProgressModel3.date = NSDate()
            inProgressModel3.word = word3
            try wordInProgressDataAccess?.saveWordInProgressEntity(inProgressModel3)
            
            var inProgressModel4 = WordInProgressModel()
            inProgressModel4.column = 0
            inProgressModel4.date = NSDate().addDay(-2)
            inProgressModel4.word = word4
            try wordInProgressDataAccess?.saveWordInProgressEntity(inProgressModel4)
            
            var inProgressModel5 = WordInProgressModel()
            inProgressModel5.column = 2
            inProgressModel5.date = NSDate().addDay(1)
            inProgressModel5.word = word5
            try wordInProgressDataAccess?.saveWordInProgressEntity(inProgressModel5)

            let wordInProgressList = try wordManager!.fetchWordsToExamin()
            XCTAssertEqual(wordInProgressList.count, 4, "Should be able to fetch wordInProgress for examine")
        }
        catch{
            XCTFail("should be able to fetch wordInProgress for examine")
        }
    }
    
    func testFetchWordsToExamineInOrder(){
        
        // it should fetch words for today and all words that belongs to past
        
        let word1 = newWordModel(context!)
        let word2 = newWordModel(context!)
        let word3 = newWordModel(context!)
        let word4 = newWordModel(context!)
        do{
            var inProgressModel1 = WordInProgressModel()
            inProgressModel1.column = 2
            inProgressModel1.date = NSDate()
            inProgressModel1.word = word1
            try wordInProgressDataAccess?.saveWordInProgressEntity(inProgressModel1)
            
            var inProgressModel2 = WordInProgressModel()
            inProgressModel2.column = 3
            inProgressModel2.date = NSDate()
            inProgressModel2.word = word2
            try wordInProgressDataAccess?.saveWordInProgressEntity(inProgressModel2)
            
            var inProgressModel3 = WordInProgressModel()
            inProgressModel3.column = 4
            inProgressModel3.date = NSDate()
            inProgressModel3.word = word3
            try wordInProgressDataAccess?.saveWordInProgressEntity(inProgressModel3)
            
            var inProgressModel4 = WordInProgressModel()
            inProgressModel4.column = 0
            inProgressModel4.date = NSDate().addDay(-2)
            inProgressModel4.word = word4
            try wordInProgressDataAccess?.saveWordInProgressEntity(inProgressModel4)
            
            let wordInProgressList = try wordManager!.fetchWordsToExamin()
            XCTAssertEqual(wordInProgressList[0].column, 4, "First column item should be 4")
            XCTAssertEqual(wordInProgressList[1].column, 3, "First column item should be 3")
            XCTAssertEqual(wordInProgressList[2].column, 2, "First column item should be 2")
            XCTAssertEqual(wordInProgressList[3].column, 0, "First column item should be 0")
            
        }
        catch{
            XCTFail("Should be able to fetch wordInProgress for examine")
        }
    }
    
    private func newWordModel(initialContext: ManagedObjectContextProtocol) -> WordModel?{
        return FlowHelper().NewWordModel(initialContext)
    }
}
