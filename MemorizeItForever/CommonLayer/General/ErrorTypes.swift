//
//  ErrorTypes.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 4/20/16.
//  Copyright © 2016 SomeSimpleSolution. All rights reserved.
//


enum WordManagementFlowError: ErrorType{
    case WordModelIsNull(String)
    case ProgressWord(String)
    case NewWordsCount(String)
    case WordInProgressIsNull(String)
}