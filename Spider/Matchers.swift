//
//  Matchers.swift
//  Spider
//
//  Created by Harry Tran on 7/17/19.
//  Copyright © 2019 Harry Tran. All rights reserved.
//

import Foundation

public protocol Matcher {
    func isEqual(to other: Matcher) -> Bool
    func matches(string: String?) -> Bool
}

public protocol Matcheable {
    func matcher() -> Matcher
}

/// Matcher from a string
public struct StringMatcher: Matcher {
    
    let string: String
    
    public init(string: String) {
        self.string = string
    }
    
    public func matches(string: String?) -> Bool {
        return self.string == string
    }
    
    public func isEqual(to other: Matcher) -> Bool {
        if let theOther = other as? StringMatcher {
            return theOther.string == string
        }
        return false
    }
}

/// Matcher from a regex
public struct RegexMatcher: Matcher {
    
    let regex: NSRegularExpression
    
    public init(regex: NSRegularExpression) {
        self.regex = regex
    }
    
    public func matches(string: String?) -> Bool {
        guard let string = string else {
            return false
        }
        return regex.numberOfMatches(in: string, options: [], range: NSRange(string.startIndex..., in: string)) > 0
    }
    
    public func isEqual(to other: Matcher) -> Bool {
        if let theOther = other as? RegexMatcher {
            return theOther.regex == regex
        }
        return false
    }
}
