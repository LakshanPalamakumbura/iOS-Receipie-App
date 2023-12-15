//
//  SignInViewController.swift
//  Techcess App
//
//  Created by Lakshan Palamakumbura on 2023-12-14.
//


import UIKit

class registerViewController: UIViewController {

    var nav: UINavigationController?

    let TitleLabel = UILabel()
    let usernameTextField = UITextField()
    let emailTextField = UITextField()
    let passwordTextField = UITextField()
    let mobileTextField = UITextField()
    let referralCodeTextField = UITextField()
    let signInButton = UIButton(type: .system)


    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()

    }

    func configureUI() {
        configureTitleLabel()
        configureUsernameTextField()
        configureEmailTextField()
        configurePasswordTextField()
        configureConfirmPasswordTextField()
        configureReferralCodeTextField()
        configuresignInButton()
    }


    func configureTitleLabel() {
        view.addSubview(TitleLabel)
        TitleLabel.translatesAutoresizingMaskIntoConstraints = false
        TitleLabel.textAlignment = .center
        TitleLabel.textColor = .darkGray
        TitleLabel.font = UIFont.systemFont(ofSize: 28.0, weight: .bold)
        TitleLabel.numberOfLines = 0
        TitleLabel.text = "Register"
//        TitleLabel.alpha = 0

        NSLayoutConstraint.activate([
                TitleLabel.widthAnchor.constraint(equalToConstant: 350),
                TitleLabel.heightAnchor.constraint(equalToConstant: 40),
                TitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                TitleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -240)

        ])
    }

    func configureUsernameTextField() {
        view.addSubview(usernameTextField)
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        usernameTextField.placeholder = "Enter User Name Here"
        usernameTextField.backgroundColor = .secondarySystemBackground

        NSLayoutConstraint.activate([
            usernameTextField.widthAnchor.constraint(equalToConstant: 350),
            usernameTextField.heightAnchor.constraint(equalToConstant: 40),
            usernameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            usernameTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -120)

        ])
    }

    func configureEmailTextField() {
        view.addSubview(emailTextField)
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.placeholder = "Enter UserEmail Here"
        emailTextField.backgroundColor = .secondarySystemBackground

        NSLayoutConstraint.activate([
            emailTextField.widthAnchor.constraint(equalToConstant: 350),
            emailTextField.heightAnchor.constraint(equalToConstant: 40),
            emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 30)

        ])
    }


   func configurePasswordTextField() {
        view.addSubview(passwordTextField)
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.placeholder = "Enter Password Here"
        passwordTextField.backgroundColor = .secondarySystemBackground
        passwordTextField.isSecureTextEntry = true
        passwordTextField.enablePasswordToggle()

        NSLayoutConstraint.activate([
            passwordTextField.widthAnchor.constraint(equalToConstant: 350),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40),
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 30)
        ])
    }

    func configureConfirmPasswordTextField() {
         view.addSubview(mobileTextField)
      mobileTextField.translatesAutoresizingMaskIntoConstraints = false
      mobileTextField.placeholder = "Mobile Number"
      mobileTextField.backgroundColor = .secondarySystemBackground
//        confirmPasswordTextField.isSecureTextEntry = true
//        confirmPasswordTextField.enablePasswordToggle()

         NSLayoutConstraint.activate([
          mobileTextField.widthAnchor.constraint(equalToConstant: 350),
          mobileTextField.heightAnchor.constraint(equalToConstant: 40),
          mobileTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
          mobileTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 30)
         ])
     }

  func configureReferralCodeTextField() {
       view.addSubview(referralCodeTextField)
    referralCodeTextField.translatesAutoresizingMaskIntoConstraints = false
    referralCodeTextField.placeholder = "Referral code"
    referralCodeTextField.backgroundColor = .secondarySystemBackground
//    referralCodeTextField.isSecureTextEntry = true
//        confirmPasswordTextField.enablePasswordToggle()

       NSLayoutConstraint.activate([
        referralCodeTextField.widthAnchor.constraint(equalToConstant: 350),
        referralCodeTextField.heightAnchor.constraint(equalToConstant: 40),
        referralCodeTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        referralCodeTextField.topAnchor.constraint(equalTo: mobileTextField.bottomAnchor, constant: 30)
       ])
   }



    func configuresignInButton() {
        view.addSubview(signInButton)
//        CWButton(backgroundColor: .systemRed, title: "Stop!")
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.configuration = .filled()
        signInButton.configuration?.imagePadding = 8.0 // for indicator spacing
        signInButton.setTitle("Sign Up", for: [])
        signInButton.addTarget(self, action: #selector(registerTapped), for: .primaryActionTriggered)
//        signInButton.addTarget(self, action: #selector(registerTapped), for: .touchUpInside)
        NSLayoutConstraint.activate([
            signInButton.widthAnchor.constraint(equalToConstant: 250),
            signInButton.heightAnchor.constraint(equalToConstant: 30),
            signInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signInButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 250)
        ])
    }

    @objc func registerTapped() {

      let parameters = ["name": usernameTextField.text!, "email": emailTextField.text!, "password": passwordTextField.text!, "phone_number": mobileTextField.text!,"referral_code": referralCodeTextField.text!]

           guard let url = URL(string: "http://127.0.0.1:8000/api/register") else { return }
           var request = URLRequest(url: url)
           request.httpMethod = "POST"
           request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
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
                       let token = json?["token"] as? String
                       UserDefaults.standard.set(token,forKey: "token")
//                       print(token)
                       if((token) != nil){
                           DispatchQueue.main.async {

                             let vc = TitlePreviewViewController()
                             vc.view.backgroundColor = .systemBackground
                              self.navigationController?.pushViewController(vc, animated: true)
                           }
                       }
                   }catch let error{
                       print("Error serializing JSON: \(error)")
                   }
               }.resume()

         }

}
