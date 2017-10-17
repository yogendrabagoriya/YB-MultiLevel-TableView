//
//  ViewController.swift
//  YBMultiLevelTableView
//
//  Created by Yogendra Bagoriya on 13/05/17.
//  Copyright © 2017 Yogendra Bagoriya. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var familtTV : UITableView!
    var familyDataSet : FamilyModel!
    var tableDataArr = Array<Any>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.automaticallyAdjustsScrollViewInsets = false
        // Do any additional setup after loading the view, typically from a nib.
        self.fetchFamilyData()
    }
    // MARK:- Other private function
    // Fetching stored data from FamilyData.plist file
    func fetchFamilyData()
    {
        let path = Bundle.main.path(forResource: "FamilyData", ofType: "plist")
        let contentDict = NSDictionary(contentsOfFile: path!) as? Dictionary<String, Any>
        if contentDict != nil
        {
            familyDataSet = FamilyModel(dataDict: contentDict!)
            tableDataArr = (familyDataSet?.grandParentMArr)!
            familtTV.reloadData()
        }
    }
    
    //MARK:- TableView Data Source Method
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return tableDataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell : FamilyTVCell?
        let member = tableDataArr[indexPath.row]
        if let grandP = member as? GrandParentModel
        {
            cell = tableView.dequeueReusableCell(withIdentifier: "Level1") as? FamilyTVCell
            cell?.titlel.text = grandP.grandParentName
        }
        else if let parent = member as? ParentModel
        {
            cell = tableView.dequeueReusableCell(withIdentifier: "Level2") as? FamilyTVCell
            cell?.titlel.text = parent.parentName
        }
        else if let child = member as? ChildModel
        {
            cell = tableView.dequeueReusableCell(withIdentifier: "Level3") as? FamilyTVCell
            cell?.titlel.text = child.childName
        }
        else
        {
             return UITableViewCell()
        }
        return cell!
    }
    
    // MARK:- UITableView Delegate Method
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.cellForRow(at: indexPath)?.isSelected = false
        let row = indexPath.row
        let member = tableDataArr[row]
        var ipsArr = Array<IndexPath>()
        if let grandP = member as? GrandParentModel
        {
            if !grandP.isExpanded
            {
                // Insert next level items
                grandP.isExpanded = true
                for (index, value) in grandP.parentMArr.enumerated()
                {
                    self.tableDataArr.insert(value, at: row + index + 1)
                    let ip = IndexPath(row: row + index + 1, section: 0)
                    ipsArr.append(ip)
                }
                tableView.beginUpdates()
                tableView.insertRows(at: ipsArr, with: .left)
                tableView.endUpdates()
            }
            else
            {
                // Delete next level items
                var count = 1
                while row + 1 < tableDataArr.count
                {
                    let element = tableDataArr[row + 1]
                    if !(element is GrandParentModel)
                    {
                        (element as? ParentModel)?.isExpanded = false
                        (element as? ChildModel)?.isExpanded = false
                        self.tableDataArr.remove(at: row + 1)
                        let ip = IndexPath(row: row + count, section: 0)
                        ipsArr.append(ip)
                        count += 1
                        
                    }
                    else if (element is GrandParentModel)
                    {
                        break
                    }
                }
                grandP.isExpanded = false
                tableView.beginUpdates()
                tableView.deleteRows(at: ipsArr, with: .right)
                tableView.endUpdates()
            }
        }
        else if let parent = member as? ParentModel
        {
            if !parent.isExpanded
            {
                parent.isExpanded = true
                for (index, value) in parent.childMArr.enumerated()
                {
                    self.tableDataArr.insert(value, at: row + index + 1)
                    let ip = IndexPath(row: row + index + 1, section: 0)
                    ipsArr.append(ip)
                }
                tableView.beginUpdates()
                tableView.insertRows(at: ipsArr, with: .left)
                tableView.endUpdates()
            }
            else
            {
                // Delete next level items
                var count = 1
                while row + 1 < tableDataArr.count
                {
                    let element = tableDataArr[row + 1]
                    if (element is GrandParentModel) || (element is ParentModel)
                    {
                        break
                    }
                    else if !(element is GrandParentModel)
                    {
                        (element as? ParentModel)?.isExpanded = false
                        (element as? ChildModel)?.isExpanded = false
                        self.tableDataArr.remove(at: row + 1)
                        let ip = IndexPath(row: row + count, section: 0)
                        ipsArr.append(ip)
                        count += 1
                        
                    }
                }
                parent.isExpanded = false
                tableView.beginUpdates()
                tableView.deleteRows(at: ipsArr, with: .right)
                tableView.endUpdates()
            }
        }
        else if member is ChildModel
        {
            // Prompt new View controller
            self.performSegue(withIdentifier: "ShowToyNameSegue", sender: self)
        }
    }
}

