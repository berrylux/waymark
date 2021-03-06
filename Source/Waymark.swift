//
//  Waymark.swift
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

public struct Waymark {
    
    // MARK: - Vars
    
    private static var root: UINavigationController?
    
    // MARK: - Methods
    
    public static func setup(aRoot: UINavigationController) {
        root = aRoot
    }
    
    public static func navigateTo(screen: Screen, transition: Transition, animated: Bool = false, context: Context? = nil, completion: (() -> ())? = nil) {
        let viewController = screen.construct(context)
        
        switch transition {
        case .Push:
            root?.top.navigationController?.pushViewController(viewController, animated: animated, completion: completion)
            break
        case .Present:
            root?.top.presentViewController(viewController, animated: animated, completion: completion)
            break
        }
    }
    
    public static func dismiss(animated: Bool = false, completion: (() -> ())? = nil) {
        root?.top.dismissViewControllerAnimated(animated, completion: completion)
    }
    
}
