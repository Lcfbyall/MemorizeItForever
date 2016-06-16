//
//  SetViewController.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 6/5/16.
//  Copyright © 2016 SomeSimpleSolution. All rights reserved.
//

import UIKit

class SetViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    var dataSource: MemorizeItTableDataSourceProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Set List"
        
        dataSource = SetTableDataSource(handleTap: didSelectSet)
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
    }
    
    func didSelectSet(model: MemorizeItModelProtocol?){
        
    }
    
}