//
//  Api.swift
//  StartupMVVMTemplate
//
//  Created by Maxime Parmantier Cloiseau on 08/11/2023.
//

import Foundation

enum Api {
    case myapi
    case custom(String, [String: String]?)
    
    private var accessor: ApiProtocol {
        switch self {
        case .myapi: return MyApi()
        case .custom(let url, let headers): return headers == nil ? CustomApi(baseUrl: url) : CustomApi(baseUrl: url, headers: headers!)
        }
    }
    
    var baseUrl: String {
        self.accessor.baseUrl
    }
    
    var headers: [String: String] {
        self.accessor.headers
    }
}

protocol ApiProtocol {
    var baseUrl: String { get }
    var headers: [String: String] { get }
}
