//
//  RxListViewController.swift
//  W5_DogAPI
//
//  Created by Beomcheol Kwon on 2021/01/30.
//

import UIKit
import RxSwift
import RxRelay
import RxCocoa

class RxListViewController: UIViewController {
    
    var viewModel = RxListViewModel()
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var listTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.setupData()
        bindingViewModel()
    }
    
    
    func bindingViewModel() {
        viewModel.dogListRelay
            .bind(to: listTableView.rx.items(cellIdentifier: "RxCell", cellType: RxCell.self)) { _, dog, cell in
                cell.dogLabel.text = dog
            }.disposed(by: disposeBag)
        
        listTableView.rx.modelSelected(String.self)
            .subscribe(onNext: {string in
                let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyBoard.instantiateViewController(identifier: "RxImageViewController") as! RxImageViewController
                vc.viewModel.dog = string
                self.navigationController?.pushViewController(vc, animated: true)
            }).disposed(by: disposeBag)
    }
}

class RxCell: UITableViewCell {
    @IBOutlet weak var dogLabel: UILabel!
    
}
