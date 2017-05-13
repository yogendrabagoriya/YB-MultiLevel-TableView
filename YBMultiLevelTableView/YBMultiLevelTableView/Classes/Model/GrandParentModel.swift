//
//  ViewController.swift
//  YBMultiLevelTableView
//
//  Created by Yogendra Bagoriya on 13/05/17.
//  Copyright © 2017 Yogendra Bagoriya. All rights reserved.
//

import Foundation

class GrandParentModel : NSObject {
    var grandParentName = ""
    var parentMArr = [ParentModel]()
    var depthLevel = 0
    var isExpanded = false
    var hasChild = false
    
    init(dataDict : Dictionary<String, Any>) {
        super.init()
        grandParentName = dataDict["grandParentName"] as! String
        let parentArr = dataDict["parent"] as! Array<Any>
        for item in parentArr
        {
            let parentM = ParentModel(dataDict: item as! Dictionary<String, Any>)
            parentMArr.append(parentM)
        }
    }
}
