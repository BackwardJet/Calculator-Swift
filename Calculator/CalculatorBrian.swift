//
//  CalculatorBrian.swift
//  Calculator
//
//  Created by Tej Vuligonda on 4/23/16.
//  Copyright © 2016 Tej Vuligonda. All rights reserved.
//

import Foundation


class CalculatorBrain {
    
    enum Op {
        case Operand(Double)
        case UnaryOperation(String, Double -> Double)
        case BinaryOperation(String, (Double, Double) -> Double)
        
    }
    
    var opStack = [Op]() //Same as Array<Op>()
    
    var knownOps = [String:Op]() //Same as Dictionary<String,Op>()
    
    init() {
        knownOps["+"] = Op.BinaryOperation("+", +)
        knownOps["-"] = Op.BinaryOperation("-", { $1 - $0 })
        knownOps["✕"] = Op.BinaryOperation("✕", +)
        knownOps["÷"] = Op.BinaryOperation("÷", { $1 / $0 })
        knownOps["√"] = Op.UnaryOperation("√", { sqrt($0) })
    }
    
    func pushOperand(operand: Double) {
        opStack.append(Op.Operand(operand))
    }
    
    func performOperation(symbol: String) {
        if let operation = knownOps[symbol] // lookup in a dictionary
        {
            opStack.append(operation)
        }
        
    }
    
    
}