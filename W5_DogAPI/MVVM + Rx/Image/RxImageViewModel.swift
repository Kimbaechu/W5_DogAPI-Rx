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
    
    var breed = ""
    var dogRelay = PublishRelay<[String: ImageLink]>()
    let disposeBag = DisposeBag()
    
    func setupData() {
        let result: Single<ImageLink> = RxNetworkService.loadData(type: .randomImage(breed))
        result.subscribe { [weak self] event in
            guard let self = self else { return }
            switch event {
            case .success(let model):
                self.dogRelay.accept([self.breed: model])

            case .error(let error):
                print(error.localizedDescription)
            }
        }.disposed(by: disposeBag)
    }
}
