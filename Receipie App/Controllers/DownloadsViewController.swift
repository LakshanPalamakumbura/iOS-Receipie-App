//
//  DownloadsViewController.swift
//  Receipie App
//
//  Created by Lakshan Palamakumbura on 2022-12-14.
//

import UIKit

class DownloadsViewController: UIViewController {

    private var responses: [FavouriteResponse] = [FavouriteResponse]()
    private let upcomingTable: UITableView = {
        
        let table = UITableView()
        table.register(FavouriteTableViewCell.self, forCellReuseIdentifier: FavouriteTableViewCell.identifier)
        return table
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "save"
        view.backgroundColor = .systemRed
    }
    
    override func viewWillAppear(_ animated: Bool) {
        view.addSubview(upcomingTable)
        upcomingTable.delegate = self
        upcomingTable.dataSource = self
        
        
        fetchUpComing()
    }
    
    private func fetchUpComing() {
        let token = UserDefaults.standard.string(forKey: "token")
                  if (token == nil) {
                      let loginViewController = loginUiViewController()
                      present(loginViewController, animated: true, completion: nil)
        
                  }else{ //use get API
                      APICaller.shared.getFavourite { [weak self] result in
                          switch result {
                          case .success(let responses):
                              self?.responses = responses
                              DispatchQueue.main.async {
                                  self?.upcomingTable.reloadData()
                              }
                              
                          case .failure(let error):
                              print(error.localizedDescription)
                          }
                          
                      }
                  }
    }    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        upcomingTable.frame = view.bounds
    }
}


extension DownloadsViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return responses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavouriteTableViewCell.identifier, for: indexPath) as? FavouriteTableViewCell else {
            return UITableViewCell()
        }
        let responses = responses[indexPath.row].food
//        let foodName = responses.name
        cell.configure(with: FavouriteViewModel(name: responses.name ?? "Unknown Title Name", image: responses.image ?? ""))
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}
