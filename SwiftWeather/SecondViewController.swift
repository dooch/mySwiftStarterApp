//
//  SecondViewController.swift
//  SwiftWeather
//
//  Created by CB on 2/02/2016.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    //Adding an Outlet from the the label om the display
    @IBOutlet weak var switchState: UILabel!
    
    var data:String?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Do any additional setup after loading the view, typically from a nib
        
        if let label = data {
            
            switchState.text = data
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
