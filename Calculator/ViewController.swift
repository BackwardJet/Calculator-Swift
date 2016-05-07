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

    var userIsInTheMiddleOfTypingANumber = false

    var brain = CalculatorBrain()
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber {
            display.text = display.text! + digit
        } else {
            display.text = digit
            userIsInTheMiddleOfTypingANumber = true;
        }
        

    }
    

    @IBAction func printCoordinates(sender: UIButton) {
        // Used for debugging to print button coordinates
        // print(sender.frame.origin.x, sender.frame.origin.y)
        
    }
    
    @IBAction func operate(sender: UIButton) {
        if userIsInTheMiddleOfTypingANumber {
            enter()
        }
        if let operation = sender.currentTitle {
            if let result = brain.performOperation(operation) {
                displayValue = result
            } else {
                displayValue = 0
            }
        }
    }
    
    

    
    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false
        if let result = brain.pushOperand(displayValue) {
            brain.pushOperand(displayValue)
        }
        else { // if result is a nil
            displayValue = 0
        }
    }
    
    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)"
            userIsInTheMiddleOfTypingANumber = false
        }
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

