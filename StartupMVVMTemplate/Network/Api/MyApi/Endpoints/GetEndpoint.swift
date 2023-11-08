//
//  ExampleEndpoint.swift
//  StartupMVVMTemplate
//
//  Created by Maxime Parmantier Cloiseau on 08/11/2023.
//

import Foundation

struct GetEndpoint: Endpoint {
    let api: Api = .myapi
    let param: String
    var path: String { "PathToEndpoint?param=\(param)" }
    let method: HttpMethod = .GET
    let headers: [String: String] = [:]
    func createBody() throws -> Data? {
        nil
    }
}
