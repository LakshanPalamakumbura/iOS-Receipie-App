//
//  TitlePreviewViewController.swift
//  Techcess App
//
//  Created by Lakshan Palamakumbura on 2023-12-14.
//

import UIKit
//import WebKit

class TitlePreviewViewController: UIViewController {

    var userId: Int?

    private let EmailLabel: UILabel = {

        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.text = "user@test.com"
        return label
    }()

    private let passwordLable: UILabel = {

        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.numberOfLines = 0 //multiple Line
        label.text = "Admin123"
        return label
    }()

    private let MobileLabel: UILabel = {

        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textColor = .red
        label.text = "077-4603387"
        return label
    }()


  private let ReferralLabel: UILabel = {

      let label = UILabel()
      label.translatesAutoresizingMaskIntoConstraints = false
      label.font = .systemFont(ofSize: 18, weight: .regular)
      label.textColor = .red
      label.text = "Ref 01"
      return label
  }()



    private let updateUserButton: UIButton = {

        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue
        button.setTitle("Update User", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(updateButtonTapped), for: .primaryActionTriggered)
        return button
    }()

    private let UserNameLabel: UILabel = {
//    let imageView = UIImageView()
////        imageView.contentMode = .scaleToFill
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        return imageView

      let label = UILabel()
      label.translatesAutoresizingMaskIntoConstraints = false
      label.font = .systemFont(ofSize: 22, weight: .bold)
      label.text = "User 1"
      return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        view.addSubview(UserNameLabel)
        view.addSubview(EmailLabel)
        view.addSubview(passwordLable)
        view.addSubview(MobileLabel)
        view.addSubview(ReferralLabel)
        view.addSubview(updateUserButton)


        configureConstraints()
    }

    func configureConstraints() {

        let userNameLabelConstraints = [
          UserNameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
          UserNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
          UserNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
          UserNameLabel.heightAnchor.constraint(equalToConstant: 80)
        ]

        let emailLabelConstraints = [
          EmailLabel.topAnchor.constraint(equalTo: UserNameLabel.bottomAnchor, constant: 20),
          EmailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ]

        let passwordLableConstraints = [
          passwordLable.topAnchor.constraint(equalTo: EmailLabel.bottomAnchor, constant: 20),
          passwordLable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
          passwordLable.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]

        let mobileLabelConstraints = [
          MobileLabel.topAnchor.constraint(equalTo: passwordLable.bottomAnchor, constant: 20),
          MobileLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
          MobileLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
      let referralLabelConstraints = [
        ReferralLabel.topAnchor.constraint(equalTo: MobileLabel.bottomAnchor, constant: 20),
        ReferralLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        ReferralLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
      ]

        let updateUserButtonButtonConstraints = [
          updateUserButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
          updateUserButton.topAnchor.constraint(equalTo: ReferralLabel.bottomAnchor, constant: 25),
          updateUserButton.widthAnchor.constraint(equalToConstant: 160),
          updateUserButton.heightAnchor.constraint(equalToConstant: 40)

        ]

        NSLayoutConstraint.activate(userNameLabelConstraints)
        NSLayoutConstraint.activate(emailLabelConstraints)
        NSLayoutConstraint.activate(passwordLableConstraints)
        NSLayoutConstraint.activate(mobileLabelConstraints)
        NSLayoutConstraint.activate(referralLabelConstraints)
        NSLayoutConstraint.activate(updateUserButtonButtonConstraints)

    }


    func configure(with model: TitlePreviewViewModel) {

//        print(model.id)
        self.userId = model.id

      UserNameLabel.text = model.name
      EmailLabel.text = model.email
      passwordLable.text = model.password
      MobileLabel.text = model.phone_number
      ReferralLabel.text = model.referral_code


    

    }



}

extension TitlePreviewViewController {

    @objc func updateButtonTapped() {


        let userId=(self.userId!)
        let token = UserDefaults.standard.string(forKey: "token")
        guard let url = URL(string: "http://127.0.0.1:8000/api//update-profile/\(userId)") else { return }
        print(url)
           var request = URLRequest(url: url)
           request.httpMethod = "POST"
           request.addValue("Bearer \(token!)", forHTTPHeaderField: "Authorization")
           request.setValue("application/json", forHTTPHeaderField: "Content-Type")

           let session = URLSession.shared
           session.dataTask(with: request){data, response, error in
                   if let error = error {
                       print("Error: \(error)")
                       return
                   }
                   guard let data = data else {
                       print("No data")
                       return
                   }
                   do{
                       let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                       let message = json?["message"] as? String

                       let alert = UIAlertController(title: "Favourite", message: message, preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                                          alert.addAction(okAction)
                                          DispatchQueue.main.async {
                                              self.present(alert, animated: true, completion: nil)
                                          }

                   }catch let error{
                       print("Error serializing JSON: \(error)")
                   }
               }.resume()

    }

}
