//
//  URLSessionHook.swift
//  Spider
//
//  Created by Harry Tran on 7/17/19.
//  Copyright © 2019 Harry Tran. All rights reserved.
//

import Foundation

final class URLSessionHook {
    
    func load() {
        guard let method = class_getInstanceMethod(originalClass(), originalSelector()),
            let stub = class_getInstanceMethod(URLSessionHook.self, #selector(protocolClasses)) else {
                fatalError("Could not load URLSessionHook")
        }
        method_exchangeImplementations(method, stub)
    }
    
    private func originalClass() -> AnyClass? {
        return NSClassFromString("__NSCFURLSessionConfiguration") ?? NSClassFromString("NSURLSessionConfiguration")
    }
    
    private func originalSelector() -> Selector {
        return #selector(getter: URLSessionConfiguration.protocolClasses)
    }
    
    @objc
    private func protocolClasses() -> [AnyClass] {
        return [HTTPStubURLProtocol.self]
    }
    
    func unload() {
        load()
    }
}
