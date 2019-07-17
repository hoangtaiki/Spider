//
//  Spider.swift
//  Spider
//
//  Created by Harry Tran on 7/16/19.
//  Copyright © 2019 Harry Tran. All rights reserved.
//

import Foundation

public class Spider {
    
    public static var `default` = Spider()
    
    public private(set) var isStarted = false
    public private(set) var stubbedRequests: [StubRequest] = []
    
    private let urlHook: HookType
    private let urlSessionHook: HookType
    
    private init() {
        urlHook = URLHook()
        urlSessionHook = URLSessionHook()
    }
    
    public func start() {
        if isStarted { return }
        
        urlHook.load()
        urlSessionHook.load()
        isStarted = true
    }
    
    public func stop() {
        if !isStarted { return }
        
        urlHook.unload()
        urlSessionHook.unload()
        isStarted = false
    }
    
    public func addStubRequest(_ request: StubRequest) {
        if let idx = stubbedRequests.firstIndex(of: request) {
            stubbedRequests[idx] = request
            return
        }
        stubbedRequests.append(request)
    }
    
    public func clearStubs() {
        stubbedRequests.removeAll()
    }
    
    public func response(for request: URLRequestType) -> StubResponse? {
        return stubbedRequests.first(where: { $0.matchesRequest(request) })?.response
    }
}
