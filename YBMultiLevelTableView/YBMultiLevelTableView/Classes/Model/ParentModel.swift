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
    var childMArr = [ChildModel]()
    var depthLevel = 1
    var isExpanded = false
    var hasChild = false
    init(dataDict : Dictionary<String, Any>) {
        super.init()
        parentName = dataDict["parentName"] as! String
        let childArr = dataDict["child"] as! Array<Any>
        for item in childArr
        {
            let topicM = ChildModel(dataDict: item as! Dictionary<String, Any>)
            childMArr.append(topicM)
        }
    }
}
