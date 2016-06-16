//
//  ErrorTypes.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 6/14/16.
//  Copyright © 2016 SomeSimpleSolution. All rights reserved.
//

public enum EntityCRUDError: ErrorType {
    case FailNewEntity(String)
    case FailSaveEntity(String)
    case FailEditEntity(String)
    case FailFetchEntity(String)
    case FailFetchEntityCount(String)
    case FailDeleteEntity(String)
}
public enum ModelError: ErrorType {
    case FailCreateModel(String)
}

public enum DataAccessError: ErrorType{
    case FailSaveData(String)
    case FailFetchData(String)
    case FailEditData(String)
    case FailDeleteData(String)
}
