//
//  RxNetworkService.swift
//  W5_DogAPI
//
//  Created by Beomcheol Kwon on 2021/01/30.
//

import Foundation
import RxSwift

struct RxNetworkService {
    static func loadData<T: Codable>(type: URLType) -> Single<T> {
        print(#function)
        guard let url = URL(string: type.makeURL) else { return Observable.error(NSError(domain: "url generation error", code: -1, userInfo: nil)).asSingle() }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        return Single<T>.create { (single) -> Disposable in
            let task = URLSession.shared.dataTask(with: request) { data, responds, error in
                if let error = error {
                    single(.error(error))
                    return
                }
                if let model: T = try? JSONDecoder().decode(T.self, from: data ?? Data()) {
                    single(.success(model))
                } else {
                    print("decoding error")
                }
            }
            task.resume()
            return Disposables.create {
                task.cancel()
            }
        }
    }
}
