//
//  TableViewController.swift
//  UMParallaxView Demo
//
//  Created by Ramon Vicente on 4/7/16.
//  Copyright © 2016 Umobi. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var headerView: UMParallaxView?
    
    var fixed: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerView = UMParallaxView(height: 200, fixed: fixed)
        headerView?.image = UIImage(named: "photo1")
        headerView?.attachTo(self.tableView)
        
        headerView?.maxHeight = 999
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        cell.textLabel?.text = "Row \(indexPath.row )"
        return cell
    }

    override func scrollViewDidScroll(scrollView: UIScrollView) {
        headerView?.scrollViewDidScroll(scrollView)
    }
}

