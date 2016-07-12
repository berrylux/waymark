//
//  Route.swift
//
//  Copyright (c) 2016 Berrylux
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import UIKit

public struct Route {
    
    // MARK: - Vars
    
    public var path: String!
//    public var screen: Screen.Type!
    public var transition: Transition!
    private var argumentsParser: ArgumentsParser!
    private var argumentsProcessor: ArgumentsProcessor!
    
    public var format: String!
    
    // MARK: - Constructors
    
//    init(path: String, screen: Screen.Type, transition: Transition, argumentsParser: ArgumentsParser, argumentsProcessor: ArgumentsProcessor) {
//        self.path = path
//        self.screen = screen
//        self.transition = transition
//        self.argumentsParser = argumentsParser
//        self.argumentsProcessor = argumentsProcessor
//        
//        format = self.argumentsParser.format(path)
//    }
    
    // MARK: - Methods
    
    func getContext(path: String) -> Any? {
        if let arguments = argumentsParser.parse(path, format) {
            return argumentsProcessor.resolve(arguments)
        }
        return nil
    }
    
}
