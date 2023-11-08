//
//  MyApi.swift
//  StartupMVVMTemplate
//
//  Created by Maxime Parmantier Cloiseau on 08/11/2023.
//

import Foundation

struct CustomApi: ApiProtocol {
    var baseUrl: String = ""
    var headers: [String: String] = [
        "Content-Type": "application/json",
        "Accept": "application/json"
    ]
}
