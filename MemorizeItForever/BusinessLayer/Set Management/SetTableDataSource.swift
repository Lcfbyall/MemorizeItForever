//
//  SetTableDataSource.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 5/25/16.
//  Copyright © 2016 SomeSimpleSolution. All rights reserved.
//

import UIKit


class SetTableDataSource: NSObject, MemorizeItTableDataSourceProtocol {
    var setModels: [SetModel]?
    var handleTap: TypealiasHelper.handleTapClosure?
    
    required init(handleTap: TypealiasHelper.handleTapClosure? = nil) {
        self.handleTap = handleTap
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sets = setModels else{
            return 0
        }
        return sets.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Default, reuseIdentifierEnum: .SetTableCellIdentifier)
        
        let set = setModels?[indexPath.row]
        
        cell.textLabel?.text = set?.name
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if let set = setModels?[indexPath.row]{
            handleTap?(model: set)
        }
        else{
            // TODO Notify an error
        }
    }
    
//    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
//        if editingStyle == UITableViewCellEditingStyle.Delete {
//            setModels.removeAtIndex(indexPath.row)
//            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
//        }
//    }
    
    func setModels(models: [MemorizeItModelProtocol]) {
        setModels = models.flatMap{$0 as? SetModel}
    }
    
}