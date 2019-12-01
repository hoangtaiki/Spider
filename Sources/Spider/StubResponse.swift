//
//  StubResponse.swift
//  Spider
//
//  Created by Harry Tran on 7/16/19.
//  Copyright © 2019 Harry Tran. All rights reserved.
//

import Foundation

public enum StubResponse {
    case success(Int, Data)
    case failed(Int, Data?, Error?)
}
