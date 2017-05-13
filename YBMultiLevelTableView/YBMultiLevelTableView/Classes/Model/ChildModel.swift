//
//  ViewController.swift
//  YBMultiLevelTableView
//
//  Created by Yogendra Bagoriya on 13/05/17.
//  Copyright © 2017 Yogendra Bagoriya. All rights reserved.
//

import Foundation

class ChildModel: NSObject {

    var childName = ""
    var toyName = ""
    var depthLevel = 2    
    var isExpanded = false
    
    init(dataDict : Dictionary<String, Any>) {
        super.init()
        childName = dataDict["childName"] as! String
        toyName = dataDict["toyName"] as! String
    }
}
