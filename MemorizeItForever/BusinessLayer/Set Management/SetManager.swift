//
//  SetManager.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 4/12/16.
//  Copyright © 2016 SomeSimpleSolution. All rights reserved.
//

import Foundation

class SetManager {
    
    private var _dataAccess: SetDataAccess?
    private var setDataAccess: SetDataAccess{
        guard let dataAccess = _dataAccess else{
            _dataAccess = SetDataAccess()
            return _dataAccess!
        }
        return dataAccess
    }
    
    init(){
        _dataAccess = nil
    }
    
    init(dataAccess: SetDataAccess){
        _dataAccess = dataAccess
    }
    
    func CreateDefaultSet() {
        do{
            if try setDataAccess.fetchSetNumber() == 0{
                var set = SetModel()
                set.name = "Default"
                try setDataAccess.saveSetEntity(set)
            }
        }
        catch{
            
        }
    }
    
    func saveSet(setName: String){
        do{
            var set = SetModel()
            set.name = setName
            try setDataAccess.saveSetEntity(set)
        }
        catch{
            
        }
    }
    
    func editSet(setModel: SetModel, setName: String){
        do{
            var set = SetModel()
            set.name = setName
            set.setId = setModel.setId
            try setDataAccess.editSetEntity(set)
        }
        catch{
            
        }
    }
    
    func deleteSet(setModel: SetModel){
        do{
            try setDataAccess.deleteSetEntity(setModel)
        }
        catch{
            
        }
    }
    
}