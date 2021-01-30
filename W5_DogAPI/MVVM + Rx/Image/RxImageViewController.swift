//
//  RxImageViewController.swift
//  W5_DogAPI
//
//  Created by Beomcheol Kwon on 2021/01/30.
//

import UIKit
import Kingfisher
import RxSwift
import RxCocoa

class RxImageViewController: UIViewController {
    
    var viewModel = RxImageViewModel()
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var imageTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.setupData()
        bindingViewModel()
    }
    
    func bindingViewModel() {
        viewModel.dogRelay
            .observeOn(MainScheduler.instance)
            .bind(to: imageTableView.rx.items(cellIdentifier: "RxImageCell", cellType: RxImageCell.self)) { _, model ,cell in
                
                cell.dogLabel.text = model.key
                cell.dogImageView.kf.setImage(with: URL(string: model.value.message))
            }.disposed(by: disposeBag)
        
        
    }
    
}

class RxImageCell: UITableViewCell {
    @IBOutlet weak var dogLabel: UILabel!
    @IBOutlet weak var dogImageView: UIImageView!
}

