//
//  APIManager.swift
//  link3
//
//  Created by Ana Howard and Antonio Fran Štignjedec on 28/07/2023.
//

import Foundation

public enum Method: String {
    case GET
    case POST
}

public protocol Endpoint {
    var path: String { get }
    var method: Method { get }
}

public protocol APIManager {
    func networkRequest(baseURL: String, endpoint: Endpoint, parameters: [String: Any]?, headers: [String: String]?) -> NSMutableURLRequest
    func networkRequestBuilder(url: URL, endpoint: Endpoint, headers: [String: String]?) -> NSMutableURLRequest
    func networkTask<T: Codable>(request: URLRequest, completionHandler: @escaping (Result<T, Error>) -> Void)
}

public class APIManagerImpl: APIManager {

    public func networkRequest(baseURL: String, endpoint: Endpoint, parameters: [String: Any]? = nil, headers: [String: String]? = nil) -> NSMutableURLRequest {
        var components = URLComponents(string: baseURL + endpoint.path)!
        guard let parameters = parameters else {
            return networkRequestBuilder(url: components.url!, endpoint: endpoint, headers: headers)
        }
        components.queryItems = parameters.map {
            URLQueryItem(name: $0, value: "\($1)")
        }

        return networkRequestBuilder(url: components.url!, endpoint: endpoint, headers: headers)
    }

    public func networkRequestBuilder(url: URL, endpoint: Endpoint, headers: [String: String]? = nil) -> NSMutableURLRequest {
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        headers?.forEach {
            request.addValue($1, forHTTPHeaderField: $0)
        }

        return request
    }

    public func networkTask<T: Codable>(request: URLRequest, completionHandler: @escaping (Result<T, Error>) -> Void) {
        let session: URLSession = URLSession.shared

        let task = session.dataTask(with: request) { data, _, error in
            guard let responseData = data, error == nil else {
                completionHandler(.failure(error!))
                return
            }

            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .secondsSince1970

            do {
                let jsonData: T = try decoder.decode(T.self, from: responseData)
                completionHandler(.success(jsonData))
            } catch let error {
                completionHandler(.failure(error))
            }

        }
        task.resume()
    }
}
