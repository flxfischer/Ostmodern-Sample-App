//
//  URLSessionDataTaskProtocol.swift
//  SafeToNetRecipes
//
//  Created by Felix Fischer on 15.03.18.
//  Copyright © 2018 Felix Fischer. All rights reserved.
//

import Foundation

protocol URLSessionDataTaskProtocol {
    func resume()
}

extension URLSessionDataTask: URLSessionDataTaskProtocol { }
