//
//  Endpoint.swift
//  StartupMVVMTemplate
//
//  Created by Maxime Parmantier Cloiseau on 08/11/2023.
//

import Foundation

protocol Endpoint {
    var api: Api { get }
    var path: String { get }
    var method: HttpMethod { get }
    var headers: [String: String] { get }
    func createBody() throws -> Data?
}

extension Endpoint {
    var fullUrl: String {
        return "\(api.baseUrl)\(path)"
    }
}
