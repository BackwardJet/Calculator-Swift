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
        func learnOp(op: Op) {
            knownOps[op.description] = op
        }
        learnOp(Op.BinaryOperation("+", +))
        learnOp(Op.BinaryOperation("-", { $1 - $0 }))
        learnOp(Op.BinaryOperation("✕", *))
        learnOp(Op.BinaryOperation("÷", { $1 / $0 }))
        learnOp(Op.UnaryOperation("√", { sqrt($0) }))
    }
    
    private func evaluate(ops: [Op]) -> (result: Double?, remaningOps: [Op]) {
        
        if !ops.isEmpty {
            var remainingOps = ops
            let op = remainingOps.removeLast()
            switch op {
            case .Operand(let operand):
                return (operand, remainingOps)
            case .UnaryOperation(_, let operation): // _ means we don't care about that value
                let operandEvaluation = evaluate(remainingOps)
                if let operand = operandEvaluation.result {
                    return (operation(operand), operandEvaluation.remaningOps)
                }
            case .BinaryOperation(_, let operation):
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
        let (result, remainder) = evaluate(opStack)
        return result
    }
    
    
    
    func pushOperand(operand: Double) -> Double? {
        opStack.append(Op.Operand(operand))
        return evaluate()
    }
    
    func performOperation(symbol: String) -> Double? {
        if let operation = knownOps[symbol] // lookup in a dictionary
        {
            opStack.append(operation)
        }
        return evaluate()
        
    }
    
    
}