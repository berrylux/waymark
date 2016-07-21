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
    public var constructScreenWithContextFromPath: ((String) -> UIViewController)!
    public var transition: Transition!
    
    private var argumentsParser: ArgumentsParser!

    // MARK: - Constructors

    init<S: Screen, AP: ArgumentsProcessor where S.Context == AP.Context>(path: String, screen: S.Type, transition: Transition, argumentsParser: ArgumentsParser, argumentsProcessor: AP) {
        self.path = path

        self.transition = transition
        self.argumentsParser = argumentsParser

        self.argumentsParser.registerFormat(path)
        constructScreenWithContextFromPath = { pathURLString in
            let arguments = self.argumentsParser.parse(path)
            let context = argumentsProcessor.resolve(arguments)
            return screen.construct(context)
        }
    }

}
