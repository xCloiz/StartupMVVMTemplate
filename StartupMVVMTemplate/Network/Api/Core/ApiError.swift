//
//  ApiError.swift
//  StartupMVVMTemplate
//
//  Created by Maxime Parmantier Cloiseau on 08/11/2023.
//

import Foundation

enum APIError: Error {
    case invalidUrl(String)
    case noResponse
    case httpError(Int, String)
    case encodeError(Error)
    case emptyResponse
}

extension APIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidUrl(let url):
            return "invalid url: \(url)"
        case .noResponse:
            return "no http response !"
        case .httpError(let code, let url):
            return "http error code \(code) for url: \(url)"
        case .encodeError(let error):
            return "Data encode error: \(error)"
        case .emptyResponse:
            return "Empty response !"
        }
    }
}
