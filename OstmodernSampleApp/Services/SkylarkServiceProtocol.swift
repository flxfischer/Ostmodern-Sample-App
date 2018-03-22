//
//  SkylarkServiceProtocol.swift
//  OstmodernSampleApp
//
//  Created by Felix Fischer on 22.03.18.
//  Copyright © 2018 Felix Fischer. All rights reserved.
//

import Foundation

protocol SkylarkServiceProtocol {
    init(session: URLSessionProtocol)
    func loadHomeSet(completion: @escaping (Result<[Episode]>)->())
}
