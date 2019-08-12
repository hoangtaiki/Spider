//
//  StringExtensions.swift
//  Spider
//
//  Created by Harry Tran on 7/18/19.
//  Copyright © 2019 Harry Tran. All rights reserved.
//

import Foundation

public extension String {
    
    func asURL() -> URL? {
        return URL(string: self)
    }
    
    func asStringMatcher() -> StringMatcher {
        return StringMatcher(string: self)
    }
}
