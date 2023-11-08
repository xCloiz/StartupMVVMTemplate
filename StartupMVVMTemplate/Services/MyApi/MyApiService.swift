//
//  MyApiService.swift
//  StartupMVVMTemplate
//
//  Created by Maxime Parmantier Cloiseau on 08/11/2023.
//

import Foundation

protocol MyApiProtocol: ServiceProtocol {
    func getExampleEndpoint(param: String, completion: @escaping (Result<String, Error>) -> Void)
    func postExampleEndpoint(param: String, completion: @escaping (Result<String, Error>) -> Void)
}

struct MyApiService: MyApiProtocol {
    let requester: APIRequestMaker
    
    func getExampleEndpoint(param: String, completion: @escaping (Result<String, Error>) -> Void) {
        requester.makeRequest(endPoint: GetEndpoint(param: param), completion: completion)
    }
    
    func postExampleEndpoint(param: String, completion: @escaping (Result<String, Error>) -> Void) {
        requester.makeRequest(endPoint: PostEndpoint(param: param), completion: completion)
    }
}
