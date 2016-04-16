//
//  ViewController.swift
//  Calculator
//
//  Created by Tej Vuligonda on 4/9/16.
//  Copyright © 2016 Tej Vuligonda. All rights reserved.
//

import UIKit

class ViewController: UIViewController { // UIViewController is the parent class
    
    @IBOutlet weak var display: UILabel!

    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        display.text = display.text! + digit
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

