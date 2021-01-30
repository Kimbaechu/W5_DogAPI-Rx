//
//  RxImageViewModel.swift
//  W5_DogAPI
//
//  Created by Beomcheol Kwon on 2021/01/30.
//

import Foundation
import RxSwift
import RxCocoa
import RxRelay

class RxImageViewModel {
    
    var dog = ""
    var dogRelay = PublishRelay<[String: ImageLink]>()
    let disposeBag = DisposeBag()
    
    func setupData() {
        print(#function)
        let result: Single<ImageLink> = RxNetworkService.loadData(type: .randomImage(dog))
        result.subscribe { [weak self] event in
            guard let self = self else { return }
            switch event {
            case .success(let model):
                print(model)
                self.dogRelay.accept([self.dog: model])

            case .error(let error):
                print(error.localizedDescription)
            }
        }.disposed(by: disposeBag)
    }
}
