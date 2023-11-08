//
//  ApiRequester.swift
//  StartupMVVMTemplate
//
//  Created by Maxime Parmantier Cloiseau on 08/11/2023.
//

import Foundation

protocol APIRequestMaker{
    func makeRequest<T:Decodable>(endPoint: Endpoint,
                                  completion: @escaping (Result<T,Error>) -> Void)
}

struct APIRequester: APIRequestMaker {
    let session: URLSession
    let timeout: TimeInterval
    
    internal init(session: URLSession = .shared,
                  timeout: TimeInterval = 30) {
        self.session = session
        self.timeout = timeout
    }
    
    func makeRequest<T:Decodable>(endPoint: Endpoint,
                                  completion: @escaping (Result<T,Error>) -> Void) {
        let urlString = endPoint.fullUrl
        let components = URLComponents(string: urlString)
        guard let url = components?.url else {
            completion(.failure(APIError.invalidUrl(urlString)))
            return
        }
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = endPoint.api.headers.merging(endPoint.headers) { _, new in new }
        request.httpMethod = endPoint.method.rawValue
        request.timeoutInterval = self.timeout
        
        print("> [\(endPoint.method.rawValue)] \(url.absoluteString)")
        
        do {
            if let body = try endPoint.createBody() {
                request.httpBody = body
            }
        } catch {
            completion(.failure(APIError.encodeError(error)))
        }
        createRequest(request: request, completion: completion)
    }
    
    private func createRequest<T:Decodable>(request: URLRequest,
                                            completion: @escaping (Result<T,Error>) -> Void) {
        createDataTasks(session: session, request: request, completion: { (result) in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async { [completion, error] in
                    completion(.failure(error))
                }
            case .success(let data):
                let decoded = decode(data, type: T.self)
                DispatchQueue.main.async { [completion, decoded] in
                    completion(decoded)
                }
            }
        }).resume()
    }
    
    func decode<T: Decodable>(_ data: Data, type: T.Type) -> Result<T, Error> {
        do {
            let mapped = try JSONDecoder().decode(type, from: data)
            return .success(mapped)
        } catch {
            print(error)
            return .failure(error)
        }
    }
    
    private func createDataTasks(session: URLSession,
                                 request: URLRequest,
                                 completion: @escaping (Result<Data,Error>) -> Void) -> URLSessionDataTask {
        session.dataTask(with: request) { (data, urlResponse, error) in
            guard let httpResponse = urlResponse as? HTTPURLResponse else {
                completion(.failure(APIError.noResponse))
                return
            }
            guard !(400..<600).contains(httpResponse.statusCode) else {
                completion(.failure(APIError.httpError(httpResponse.statusCode,
                                                       httpResponse.url?.absoluteString ?? "unknown")))
                return
            }
            if httpResponse.statusCode == 204 {
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: [], options: .prettyPrinted)
                    completion(.success(jsonData))
                } catch {
                    completion(.failure(error))
                }
            } else {
                if let data = data {
                    completion(.success(data))
                } else {
                    completion(.failure(APIError.emptyResponse))
                }
            }
        }
    }
}
