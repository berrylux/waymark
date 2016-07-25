//
//  StringExtensions.swift
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

import Foundation

public extension String {
    
    public var fullRange: NSRange {
        return NSMakeRange(0, length)
    }
    
    public var length: Int {
        return characters.count
    }
    
    public func substring(aRange: Range<Index>) -> String {
        return substringWithRange(aRange)
    }
    
    public func substring(range: NSRange) -> String {
        return (self as NSString).substringWithRange(range)
    }
    
    public func removeChars(chars: String) -> String {
        let toRemove = NSCharacterSet(charactersInString: chars)
        return self.componentsSeparatedByCharactersInSet(toRemove).joinWithSeparator("")
    }
    
    public func replace(toReplace: String, with replacement: String) -> String {
        return stringByReplacingOccurrencesOfString(toReplace, withString: replacement)
    }
    
    public func replace(range range: Range<Index>, with replacement: String) -> String {
        return stringByReplacingCharactersInRange(range, withString: replacement)
    }
    
}
