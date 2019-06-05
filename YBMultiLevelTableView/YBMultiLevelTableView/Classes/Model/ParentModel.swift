//
//  ViewController.swift
//  YBMultiLevelTableView
//
//  Created by Yogendra Bagoriya on 13/05/17.
//  Copyright © 2017 Yogendra Bagoriya. All rights reserved.
//

import Foundation

class ParentModel: NSObject {

    var parentName = ""
    var depthLevel = 1
    init(dataDict : Dictionary<String, Any>) {
        super.init()
        parentName = dataDict["parentName"] as! String
    }
}
