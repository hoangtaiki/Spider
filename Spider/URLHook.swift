//
//  URLHook.swift
//  Spider
//
//  Created by Harry Tran on 7/17/19.
//  Copyright © 2019 Harry Tran. All rights reserved.
//

import Foundation

final class URLHook {
    
    func load() {
        URLProtocol.registerClass(HTTPStubURLProtocol.self)
    }
    
    func unload() {
        URLProtocol.unregisterClass(HTTPStubURLProtocol.self)
    }
}
