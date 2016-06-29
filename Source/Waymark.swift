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
    
    // MARK: - Types
    
    private struct DefaultArgumentsParser: ArgumentsParser {}
    private struct DefaultArgumentsProcessor: ArgumentsProcessor {}
    
    // MARK: - Vars
    
    private static var root: UINavigationController?
    
    private static var routes = [Route]()
    
    private static var defaultArgumentsParser = DefaultArgumentsParser()
    private static var defaultArgumentsProcessor = DefaultArgumentsProcessor()
    
    // MARK: - Setup
    
    public static func setup(aRoot: UINavigationController) {
        root = aRoot
    }
    
    // MARK: - Transitioning
    
    public static func push(screen: Screen, context: Context? = nil, animated: Bool = false, completion: (() -> ())? = nil) {
        let transition = Transition.Push(animated: animated, completion: completion)
        processTransition(transition, screen: screen, context: context)
    }
    
    public static func present(screen: Screen, context: Context? = nil, animated: Bool = false, completion: (() -> ())? = nil) {
        let transition = Transition.Present(animated: animated, completion: completion)
        processTransition(transition, screen: screen, context: context)
    }
    
    private static func processTransition(transition: Transition, screen: Screen, context: Context? = nil) {
        let viewController = screen.construct(context)
        
        switch transition {
        case let .Push(animated, completion):
            root?.pushViewController(viewController, animated: animated, completion: completion)
            break
        case let .Present(animated, completion):
            root?.top.presentViewController(viewController, animated: animated, completion: completion)
            break
        }
    }
    
    public static func dismiss(animated: Bool = false, completion: (() -> ())? = nil) {
        root?.top.dismissViewControllerAnimated(animated, completion: completion)
    }
    
    // MARK: - Routes
    
    public static func addPath(path: String, screen: Screen, transition: Transition, anArgumentsParser: ArgumentsParser? = nil, anArgumentsProcessor: ArgumentsProcessor? = nil) {
        if getRoute(path) == nil {
            let argumentsParser = anArgumentsParser ?? defaultArgumentsParser
            let argumentsProcessor = anArgumentsProcessor ?? defaultArgumentsProcessor
            let route = Route(
                path: path,
                format: argumentsParser.format(path),
                screen: screen,
                transition: transition,
                argumentsParser: argumentsParser,
                argumentsProcessor: argumentsProcessor
            )
            
            routes.append(route)
        } else {
            print("Failed to create and add route with path: \(path). Route with this path already exists.")
        }
    }
    
    public static func processUrl(url: NSURL) {
        processPath(url.absoluteString)
    }
    
    public static func processPath(path: String) {
        // TODO: Logic to find route by path
        guard let route = getRoute(path) else { return }
        processPath(path, route: route)
    }
    
    private static func processPath(path: String, route: Route) {
        let arguments = route.argumentsParser.parse(path, route.format)
        let context = route.argumentsProcessor.resolve(arguments)
        
        processTransition(route.transition, screen: route.screen, context: context)
    }
    
    public static func getRoute(path: String) -> Route? {
        return routes.filter { $0.path == path }.first
    }
    
}
