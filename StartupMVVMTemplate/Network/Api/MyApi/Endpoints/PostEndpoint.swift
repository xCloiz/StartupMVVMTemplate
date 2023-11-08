//
//  PostEndpoint.swift
//  StartupMVVMTemplate
//
//  Created by Maxime Parmantier Cloiseau on 08/11/2023.
//

import Foundation

struct PostEndpoint: Endpoint {
    let api: Api = .myapi
    let param: String
    var path: String { "PathToEndpoint?param=\(param)" }
    let method: HttpMethod = .POST
    let headers: [String: String] = [:]
    func createBody() throws -> Data? {
        // You can return your body as json for example
        return nil
    }
}
