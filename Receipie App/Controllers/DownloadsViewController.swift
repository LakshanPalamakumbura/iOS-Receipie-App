//
//  DownloadsViewController.swift
//  Receipie App
//
//  Created by Lakshan Palamakumbura on 2022-12-14.
//

import UIKit

class DownloadsViewController: UIViewController {

    let titleLable = UILabel()//add for testing
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
        configureTitleLabel()//add for testing
        // Do any additional setup after loading the view.
    }
    
    func configureTitleLabel(){
        view.addSubview(titleLable)
        titleLable.translatesAutoresizingMaskIntoConstraints = false
        titleLable.text = "This shows your food"
        titleLable.font = .systemFont(ofSize: 40, weight: .bold)
        titleLable.textColor = .red
        titleLable.textAlignment = .center
        titleLable.numberOfLines = 0

        NSLayoutConstraint.activate([
            titleLable.widthAnchor.constraint(equalToConstant: 250),
            titleLable.heightAnchor.constraint(equalToConstant: 350),
            titleLable.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLable.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -75)
            
        ])
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
