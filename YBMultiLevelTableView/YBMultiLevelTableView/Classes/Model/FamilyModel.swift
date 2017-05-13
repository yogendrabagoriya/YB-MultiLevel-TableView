//
//  ViewController.swift
//  YBMultiLevelTableView
//
//  Created by Yogendra Bagoriya on 13/05/17.
//  Copyright © 2017 Yogendra Bagoriya. All rights reserved.
//

import Foundation

class FamilyModel : NSObject {

    var grandParentMArr = [GrandParentModel]()
    
    init(dataDict : Dictionary<String, Any>) {
        super.init()
        let grandParentList = dataDict["grandParent"] as! Array<Any>
        for item in grandParentList
        {
            let grandparentM = GrandParentModel(dataDict: item as! Dictionary<String , Any>)
            grandParentMArr.append(grandparentM)
        }
    }
}
