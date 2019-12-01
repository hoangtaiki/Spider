//
//  URLHook.swift
//  Spider
//
//  Created by Harry Tran on 7/17/19.
//  Copyright © 2019 Harry Tran. All rights reserved.
//

import Foundation

public protocol HookType {
    func load()
    func unload()
}

final class URLHook: HookType {
    
    func load() {
        URLProtocol.registerClass(StubURLProtocol.self)
    }
    
    func unload() {
        URLProtocol.unregisterClass(StubURLProtocol.self)
    }
}
