//
//  NetworkService.swift
//  W5_DogAPI
//
//  Created by Beomcheol Kwon on 2021/01/29.
//

import Foundation
import Alamofire

enum APIError: Error {
    case response
}

enum URLType {
    case list
    case randomImage(String)
    
    var baseURL: String {
        return "https://dog.ceo/api/"
    }
    
    var makeURL: String {
        switch self {
        case .list:
            return "\(baseURL)breeds/list/all"
        case .randomImage(let breed):
        return "\(baseURL)breed/\(breed)/images/random"
        }
    }
}

struct NetworkService {
    static func loadData<T: Codable>(type: URLType, completion: @escaping (Result<T,APIError>) -> Void) {
        AF.request(type.makeURL)
            .responseDecodable(of: T.self) { response in
                guard let target = response.value else {
                    return completion(.failure(.response))
                }
                completion(.success(target))
            }
    }
}
