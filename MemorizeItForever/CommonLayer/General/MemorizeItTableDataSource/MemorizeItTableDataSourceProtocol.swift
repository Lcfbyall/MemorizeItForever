//
//  MemorizeItTableDataSource.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 5/25/16.
//  Copyright © 2016 SomeSimpleSolution. All rights reserved.
//

import UIKit

protocol MemorizeItTableDataSourceProtocol: UITableViewDataSource, UITableViewDelegate {
    func setModels(models: [MemorizeItModelProtocol])
    init(handleTap: TypealiasHelper.handleTapClosure?)
}
