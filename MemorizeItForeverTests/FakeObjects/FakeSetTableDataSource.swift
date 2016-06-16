//
//  FakeSetTableDataSource.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 6/7/16.
//  Copyright © 2016 SomeSimpleSolution. All rights reserved.
//

import UIKit
import BaseDataAccess
@testable import MemorizeItForever

class FakeSetTableDataSource: NSObject, MemorizeItTableDataSourceProtocol{
    
    var handleTap: TypealiasHelper.handleTapClosure?
    
    func setModels(models: [MemorizeItModelProtocol]) {
        
    }
    
    required init(handleTap: TypealiasHelper.handleTapClosure?) {
        self.handleTap = handleTap
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            return UITableViewCell()
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        handleTap!(model: SetModel(setId: NSUUID(), name: "Default"))
    }
    
}
