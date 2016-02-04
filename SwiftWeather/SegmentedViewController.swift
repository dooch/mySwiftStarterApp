//
//  SegmentedViewController.swift
//  SwiftWeather
//
//  Created by CB on 4/02/2016.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit

class SegmentedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //Adding an Outlet from the the label om the display
    
    @IBOutlet weak var mySegmentedControl: UISegmentedControl!
    @IBOutlet weak var myTableView: UITableView!
    
    
    let privateList:[String] = ["Private Item 1", "Private Item2", "Private Item 3"]
    let friendsAndFamily:[String] = ["Friend 1", "Friend 2", "Friend 3", "Friend 4"]
    let publicList:[String] = ["Public 1", "Public2", "Public3"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Do any additional setup after loading the view, typically from a nib
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //This is where I have added in some code which I have copied from the Protocol library
    
    @available(iOS 2.0, *)
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    
    {
     var returnValue = 0
        
        switch(mySegmentedControl.selectedSegmentIndex)
        {
        case 0:
            returnValue = privateList.count
            break
        case 1:
            returnValue = friendsAndFamily.count
            break
        case 2:
            returnValue = publicList.count
            break
        default:
            break
        }
        
        privateList.count
        
        return returnValue
    
    }
    @available(iOS 2.0, *)
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    
    {
    
     let myCell = tableView.dequeueReusableCellWithIdentifier("myCell", forIndexPath: indexPath)
    
        
        switch(mySegmentedControl.selectedSegmentIndex)
        {
        case 0:
            myCell.textLabel!.text = privateList[indexPath.row]
            break
        case 1:
            myCell.textLabel!.text = friendsAndFamily[indexPath.row]
            break
        case 2:
            myCell.textLabel!.text = publicList[indexPath.row]
            break
        default:
            break
        }
        
        return myCell
    }
    

    @IBAction func refreshButtonTapped(sender: AnyObject) {
    }
    
    @IBAction func segmentedControlActionChanged(sender: AnyObject) {
        
        myTableView.reloadData()
    }
    
    
    
}

