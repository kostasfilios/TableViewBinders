//
//  Functional.swift
//  Novibet
//
//  Created by Kostas Filios on 31/7/20.
//  Copyright © 2020 Novibet. All rights reserved.
//

import Foundation

precedencegroup Forwarding {
    associativity: left
}

//MARK: - |>> operator curried chain

infix operator |>>: Forwarding

func |>> <A, B, C>(f: @escaping (A) -> B, g: @escaping (B) -> C) -> ((A) -> C) {
    return { g(f($0)) }
}

//MARK: - |> operator pipe forwaring

infix operator |>: Forwarding

func |> <A, B>(a: A, f: (A) -> B) -> B { 
  return f(a)
}

//MARK: - ||>> operator conditioned composition

infix operator ||>>: Forwarding

func ||>> <A, B, C> (f: @escaping (A) -> B, conditionList: [((B) -> Bool, (B) -> C)] ) -> ((A) -> C?) {
    return { a in
        let b = f(a)
        for condition in conditionList {
            if (condition.0(b)) {
                return condition.1(b)
            }
        }
        return nil
    }
}

// MARK: - Free functional methods
func noOP<A>() -> (A) -> (A) {
    return { $0 }
}

func boolCheck<A>(_ condition: @escaping (A) -> Bool) -> (A) -> (Bool) {
    return { a in
        condition(a)
    }
}

// MARK: - Boolean functional extension
extension Bool {
    func mySelf() -> (Bool) -> Bool {
        return { _ in
            self
        }
    }
    
    func myOpposite() -> (Bool) -> Bool {
        return { _ in
            !self
        }
    }
}
