//
//  main.swift
//  scale
//
//  Created by Vitor Silva on 01/04/20.
//  Copyright © 2020 Vitor Silva. All rights reserved.
//

import Foundation

if CommandLine.arguments.count != 4 {
    errorExit("""
    Invalid number of arguments.
    $ scale WIDTHxHEIGHT MODE NEW_VALUE
    MODE = [wh]
    w -> return width for given height
    h -> return height for given width
    """)
}

enum Mode {
    case width, height
}

let original = validateOriginal(CommandLine.arguments[1])
let mode = validateMode(CommandLine.arguments[2])
let target = validateTarget(CommandLine.arguments[3])

switch mode {
case .width:
    print(Double(original.width) / Double(original.height) * Double(target))
case .height:
    print(Double(original.height) / Double(original.width) * Double(target))
}

// Helper functions

func validateOriginal(_ str: String) -> (width: Int, height: Int) {
    let numbers = str.split(separator: "x")
    if numbers.count == 2, let width = Int(numbers[0]), let height = Int(numbers[1]) {
        return (width: width, height: height)
    }
    
    errorExit("""
    Error: first parameter must be of type WIDTHxHEIGHT
    """)
}

func validateMode(_ str: String) -> Mode {
    if str == "w" { return .width }
    if str == "h" { return .height }
    
    errorExit("""
    Error: second parameter must be w for width or h for height
    """)
}

func validateTarget(_ str: String) -> Int {
    if let number = Int(str) {
        return number
    }
    
    errorExit("""
    Error: third parameter must be an integer
    """)
}

func errorExit(_ msg: String) -> Never {
    print(msg)
    exit(EXIT_FAILURE)
}
