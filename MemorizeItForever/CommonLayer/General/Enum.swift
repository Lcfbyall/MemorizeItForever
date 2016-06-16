//
//  Enum.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 3/25/16.
//  Copyright © 2016 SomeSimpleSolution. All rights reserved.
//


enum Entities: String{
    case SetEntity
    case WordEntity
    case WordInProgressEntity
    case WordHistoryEntity
}
enum Models: String{
    case SetModel
    case WordModel
    case WordHistoryModel
    case WordInProgressModel
}

enum Settings: String{
    case WordSwitching 
    case NewWordsCount 
    case JudgeMyself
    case PhraseColor
    case MeaningColor
}
enum MemorizeColumns: Int {
    case pre = 0
    case first = 1
    case second = 2
    case third = 3
    case fourth = 4
    case fifth = 5
}
enum WordStatus: Int{
    case NotStarted = 0
    case InProgress = 1
    case Done = 2
}
enum CellReuseIdentifier: String{
    case SetTableCellIdentifier = "SetTableCellIdentifier"
}
enum NotificationName: String{
    case SetTableDataSourceDidSelectItemNotification
}