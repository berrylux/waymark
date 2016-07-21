//
//  ArgumentsParser.swift
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

public protocol ArgumentsParser {
    var format: String! { get set }
    mutating func registerFormat(path: String)
    func parse(path: String) -> [String: AnyObject]?
}

public struct DefaultArgumentsParser: ArgumentsParser {
    
    // MARK: - Vars
    
    private var argumentsTitles: [String] = []
    public var format: String! = ""
    
    // MARK: - ArgumentsParser
    
    public mutating func registerFormat(path: String) { // TODO: Dont like this name
        var format = path.stringByReplacingOccurrencesOfString("/", withString: "\\/").stringByReplacingOccurrencesOfString("?", withString: "\\?")
        var argumentRanges = [Range<Int>]()
        
        var latestRange: Range<Int>?
        for (charIdx, char) in format.characters.enumerate() {
            if char == "{" {
                latestRange = charIdx ... charIdx
            } else if char == "}", var range = latestRange {
                range.endIndex = charIdx
                argumentRanges.append(range)
                latestRange = nil
            }
        }
        
        let initialFormatLength = format.characters.count
        
        // TODO: Extend regex?, maybe change to (\\w+)
        let regexAny = "([а-яА-Яa-zA-Z0-9_]+)"
        for range in argumentRanges {
            let advanceBy = format.characters.count - initialFormatLength
            
            let startIndex = format.characters.startIndex.advancedBy(range.startIndex + advanceBy)
            let endIndex = format.characters.startIndex.advancedBy(range.endIndex + advanceBy)
            let range = startIndex ... endIndex
            
            argumentsTitles.append(format.substringWithRange(range).remove("{}"))
            format = format.stringByReplacingCharactersInRange(range, withString: regexAny)
        }
    }
    
    public func parse(path: String) -> [String: AnyObject]? {
        do {
            let regex = try NSRegularExpression(pattern: format, options: NSRegularExpressionOptions.CaseInsensitive)
            let range = NSMakeRange(0, path.characters.count)
            if let textCheckingResults = regex.firstMatchInString(path, options: [], range: range) where textCheckingResults.numberOfRanges > 1 {
                
                var values = [String: AnyObject]()
                
                for index in 1 ..< textCheckingResults.numberOfRanges where index <= argumentsTitles.count {
                    let title = argumentsTitles[index - 1]
                    values[title] = path.substringWithRange(textCheckingResults.rangeAtIndex(index))
                }
                
                return values
                
            }
        } catch {}
        
        return nil
    }
}
