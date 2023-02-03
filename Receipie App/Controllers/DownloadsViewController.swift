//
//  DownloadsViewController.swift
//  Receipie App
//
//  Created by Lakshan Palamakumbura on 2022-12-14.
//

import UIKit

class DownloadsViewController: UIViewController {

    private var responses: [Response] = [Response]()
    private let upcomingTable: UITableView = {
        
        let table = UITableView()
        table.register(FavouriteTableViewCell.self, forCellReuseIdentifier: FavouriteTableViewCell.identifier)
        return table
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
        view.addSubview(upcomingTable)
        upcomingTable.delegate = self
        upcomingTable.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        upcomingTable.frame = view.bounds
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

    
 
    //    let token = UserDefaults.standard.string(forKey: "token")
    //          if (token == nil) {
    //              let loginViewController = LoginViewController()
    //              present(loginViewController, animated: true, completion: nil)
    //
    //          }else{
    //
    //              //get favourites
    //
    //
    //          }
    
}


extension DownloadsViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return responses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//            let cell =  tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//            cell.textLabel?.text = titles[indexPath.row].original_name ?? titles[indexPath.row].original_title ?? "Unknown"
//            return cell
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavouriteTableViewCell.identifier, for: indexPath) as? FavouriteTableViewCell else {
            return UITableViewCell()
        }
        let responses = responses[indexPath.row]
        let foodName = responses.name
//        guard let foodImage = responses.image else { return } //else { return  }
//        let viewModel = FavouriteViewModel(name: foodName)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}
