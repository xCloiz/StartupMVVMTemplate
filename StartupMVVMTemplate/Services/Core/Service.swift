//
//  Service.swift
//  StartupMVVMTemplate
//
//  Created by Maxime Parmantier Cloiseau on 08/11/2023.
//

import Foundation

protocol ServiceProtocol {
    var requester: APIRequestMaker { get }
}
