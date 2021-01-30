//
//  ImageViewController.swift
//  W5_DogAPI
//
//  Created by Beomcheol Kwon on 2021/01/29.
//

import UIKit
import Alamofire
import Kingfisher

class ImageViewController: UIViewController {
    
    var imageLink: String = ""
    var breed: String = ""
    
    @IBOutlet weak var imageTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        imageTableView.dataSource = self
        imageTableView.delegate = self
        setUpData()
    }
    
    func setUpData() {
        NetworkService.loadData(type: .randomImage(breed)) { [weak self] (result: Result<ImageLink,APIError>) in
            switch result {
            case .success(let model):
                self?.imageLink = model.message
                self?.imageTableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
}

extension ImageViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ImageCell", for: indexPath) as! ImageCell
        cell.dogLabel.text = breed
        cell.dogImageView.kf.setImage(with: URL(string: imageLink))
        return cell
    }
    
}

class ImageCell: UITableViewCell {
    @IBOutlet weak var dogLabel: UILabel!
    @IBOutlet weak var dogImageView: UIImageView!
}
