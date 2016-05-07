//
//  CalculatorBrian.swift
//  Calculator
//
//  Created by Tej Vuligonda on 4/23/16.
//  Copyright © 2016 Tej Vuligonda. All rights reserved.
//

import Foundation


class CalculatorBrain {
    
    private enum Op: CustomStringConvertible {
        case Operand(Double) // a number
        case UnaryOperation(String, Double -> Double)
        case BinaryOperation(String, (Double, Double) -> Double)
        
        var description: String {
            get {
                switch self {
                case .Operand(let operand):
                    return "\(operand)"
                case .UnaryOperation(let symbol, _):
                    return symbol
                case .BinaryOperation(let symbol, _):
                    return symbol
                }
            }
        }
        
    }
    
    private var opStack = [Op]() //Same as Array<Op>()
    
    private var knownOps = [String:Op]() //Same as Dictionary<String,Op>()
    
    init() {
        knownOps["+"] = Op.BinaryOperation("+", +)
        knownOps["-"] = Op.BinaryOperation("-", { $1 - $0 })
        knownOps["✕"] = Op.BinaryOperation("✕", *)
        knownOps["÷"] = Op.BinaryOperation("÷", { $1 / $0 })
        knownOps["√"] = Op.UnaryOperation("√", { sqrt($0) })
    }
    
    private func evaluate(ops: [Op]) -> (result: Double?, remaningOps: [Op]) {
        print("evaluate(\(ops))")
        
        if !ops.isEmpty {
            var remainingOps = ops
            let op = remainingOps.removeLast()
            switch op {
            case .Operand(let operand):
                print("operand: \(operand)")
                return (operand, remainingOps)
            case .UnaryOperation(_, let operation): // _ means we don't care about that value
                print("unary case")
                let operandEvaluation = evaluate(remainingOps)
                if let operand = operandEvaluation.result {
                    return (operation(operand), operandEvaluation.remaningOps)
                }
            case .BinaryOperation(_, let operation):
                print("binary case")
                let op1Evaluation = evaluate(remainingOps)
                if let operand1 = op1Evaluation.result {
                    let op2Evaluation = evaluate(op1Evaluation.remaningOps)
                    if let operand2 = op2Evaluation.result {
                        return (operation(operand1, operand2), op2Evaluation.remaningOps)
                    }
                }
            }
        }
        return (nil, ops)
        
    }
    
    func evaluate() -> Double? {
        print("evaluate()")
        let (result, remainder) = evaluate(opStack)
        print("\(opStack) = \(result) with \(remainder) left over")
        return result
    }
    
    
    
    func pushOperand(operand: Double) -> Double? {
        print("pushOp(\(operand))")
        opStack.append(Op.Operand(operand))
        return evaluate()
    }
    
    func performOperation(symbol: String) -> Double? {
        print("performOp(\(symbol))")
        if let operation = knownOps[symbol] // lookup in a dictionary
        {
            opStack.append(operation)
        }
        return evaluate()
        
    }
    
    
}