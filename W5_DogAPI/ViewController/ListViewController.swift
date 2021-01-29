//
//  ListViewController.swift
//  W5_DogAPI
//
//  Created by Beomcheol Kwon on 2021/01/29.
//

import UIKit
import Alamofire

class ListViewController: UIViewController {
    
    var dogList = [String]()
    
    @IBOutlet weak var listTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listTableView.dataSource = self
        listTableView.delegate = self
        setUpData()
    }
    
    func setUpData() {
        NetworkService.loadData(type: .list) { [weak self] (result: Result<DogList,APIError>) in
            switch result {
            case .success(let model):
                self?.dogList = model.message.map { $0.key }.sorted(by: <)
                self?.listTableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ImageViewController, let index = sender as? Int {
            vc.breed = dogList[index]
        }
    }
}

extension ListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dogList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = dogList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "Detail", sender: indexPath.row)
    }
    
}
