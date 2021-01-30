//
//  RxListViewModel.swift
//  W5_DogAPI
//
//  Created by Beomcheol Kwon on 2021/01/30.
//

import Foundation
import RxSwift
import RxRelay

class RxListViewModel {
    
    var dogList = [String]()
    let dogListRelay = PublishRelay<[String]>()
    let disposeBag = DisposeBag()
    
    func setupData() {
        print("RxSetup")
        let result: Single<DogList> = RxNetworkService.loadData(type: .list)
        result.subscribe { [weak self] event in
            guard let self = self else { return }
            switch event {
            case .success(let model):
                self.dogList = model.message.map { $0.key }.sorted(by: <)
                self.dogListRelay.accept(self.dogList)
            case .error(let error):
                print(error.localizedDescription)
            }
        }.disposed(by: disposeBag)
    }
}

