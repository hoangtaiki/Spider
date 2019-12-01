//
//  URLSessionHook.swift
//  Spider
//
//  Created by Harry Tran on 7/17/19.
//  Copyright © 2019 Harry Tran. All rights reserved.
//

import Foundation

final class URLSessionHook: HookType {
    
    func load() {
        guard let method = class_getInstanceMethod(originalClass(), originalSelector()),
            let stub = class_getInstanceMethod(URLSessionHook.self, #selector(protocolClasses)) else {
                fatalError("Could not load URLSessionHook")
        }
        method_exchangeImplementations(method, stub)
    }
    
    func unload() {
        load()
    }
    
    private func originalClass() -> AnyClass? {
        return NSClassFromString("__NSCFURLSessionConfiguration")
    }
    
    private func originalSelector() -> Selector {
        return #selector(getter: URLSessionConfiguration.protocolClasses)
    }
    
    @objc
    private func protocolClasses() -> [AnyClass] {
        return [StubURLProtocol.self]
    }
}
