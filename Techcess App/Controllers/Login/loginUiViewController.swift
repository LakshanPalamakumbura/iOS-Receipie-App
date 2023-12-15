//
//  loginUiViewController.swift
//  Techcess App
//
//  Created by Lakshan Palamakumbura on 2023-12-14.
//

import UIKit

class loginUiViewController: UIViewController {

    var nav: UINavigationController?

    let TitleLabel = UILabel()
    let TitleInfoLabel = UILabel()
    let signInButton = UIButton(type: .system)
    let errorMessageLabel = UILabel()
    let emailTextField = UITextField()
    let passwordTextField = UITextField()

    // animation
    var leadingEdgeOnScreen: CGFloat = 16.0
    var leadingEdgeOffScreen: CGFloat = -1000.0

    var titleLeadingAnchor: NSLayoutConstraint?
    var subtitleLeadingAnchor: NSLayoutConstraint?

    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animate()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        signInButton.configuration?.showsActivityIndicator = false
    }
}




extension loginUiViewController {

    private func style() {
        TitleLabel.translatesAutoresizingMaskIntoConstraints = false
        TitleLabel.textAlignment = .center
        TitleLabel.textColor = .darkGray
        TitleLabel.font = UIFont.systemFont(ofSize: 28.0, weight: .bold)
        TitleLabel.numberOfLines = 0
        TitleLabel.text = "Techcess App"
        TitleLabel.alpha = 0

        TitleInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        TitleInfoLabel.textAlignment = .center
        TitleInfoLabel.textColor = .gray
        TitleInfoLabel.numberOfLines = 0
        TitleInfoLabel.text = "Get Redy for sign with us!"
        TitleInfoLabel.alpha = 0

        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.placeholder = "Enter UserEmail Here"
        emailTextField.backgroundColor = .secondarySystemBackground

        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.placeholder = "Enter Password Here"
        passwordTextField.backgroundColor = .secondarySystemBackground
        passwordTextField.isSecureTextEntry = true
        passwordTextField.enablePasswordToggle()

        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.configuration = .filled()
        signInButton.configuration?.imagePadding = 8.0 // for indicator spacing
        signInButton.setTitle("Sign In", for: [])
        signInButton.addTarget(self, action: #selector(signInButtonTapped), for: .primaryActionTriggered)

        errorMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        errorMessageLabel.textAlignment = .center
        errorMessageLabel.textColor = .systemRed
        errorMessageLabel.numberOfLines = 0
        errorMessageLabel.isHidden = true
    }

    private func layout() {
        view.addSubview(TitleLabel)
        view.addSubview(TitleInfoLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)

        view.addSubview(signInButton)
        view.addSubview(errorMessageLabel)
//        view.addSubview(signUpButton)


        NSLayoutConstraint.activate([
            TitleLabel.widthAnchor.constraint(equalToConstant: 350),
            TitleLabel.heightAnchor.constraint(equalToConstant: 40),
            TitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            TitleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -150)
        ])

        NSLayoutConstraint.activate([
            TitleInfoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            TitleInfoLabel.topAnchor.constraint(equalTo: TitleLabel.bottomAnchor, constant: 30),
            TitleInfoLabel.widthAnchor.constraint(equalToConstant: 250),
            TitleInfoLabel.heightAnchor.constraint(equalToConstant: 30)
        ])

        NSLayoutConstraint.activate([
            emailTextField.widthAnchor.constraint(equalToConstant: 350),
            emailTextField.heightAnchor.constraint(equalToConstant: 40),
            emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -10)
         ])

         NSLayoutConstraint.activate([
            passwordTextField.widthAnchor.constraint(equalToConstant: 350),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40),
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 30)
         ])

         NSLayoutConstraint.activate([
            signInButton.widthAnchor.constraint(equalToConstant: 250),
            signInButton.heightAnchor.constraint(equalToConstant: 30),
            signInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signInButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 150)
        ])

        NSLayoutConstraint.activate([
            errorMessageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorMessageLabel.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 30),
            errorMessageLabel.widthAnchor.constraint(equalToConstant: 250),
            errorMessageLabel.heightAnchor.constraint(equalToConstant: 15)
        ])



    }



}

// MARK: - Actions
extension loginUiViewController {
//    @objc func signInButtonTapped(sender: UIButton) {
//        errorMessageLabel.isHidden = true
//        signin()
//        }

    @objc func signInButtonTapped() {

        errorMessageLabel.isHidden = true

        let parameters = ["email": emailTextField.text!, "password": passwordTextField.text!]

           guard let url = URL(string: "http://127.0.0.1:8000/api/login") else { return }
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

//                               let vc = SearchViewController()
//                               vc.view.backgroundColor = .systemBackground
//                               self.nav?.pushViewController(vc, animated: true)


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



    private func configureView(withMessage message: String) {
        errorMessageLabel.isHidden = false
        errorMessageLabel.text = message
        shakeButton()
    }
}

// MARK: - Animations
private extension loginUiViewController {
    func animate() {

        let duration = 2.0

        let animator1 = UIViewPropertyAnimator(duration: duration, curve: .easeInOut) {
            self.titleLeadingAnchor?.constant = self.leadingEdgeOnScreen
            self.view.layoutIfNeeded()
        }
        animator1.startAnimation()

        let animator2 = UIViewPropertyAnimator(duration: duration, curve: .easeInOut) {
            self.subtitleLeadingAnchor?.constant = self.leadingEdgeOnScreen
            self.view.layoutIfNeeded()
        }
        animator2.startAnimation(afterDelay: 1.0)

        let animator3 = UIViewPropertyAnimator(duration: duration * 2, curve: .easeInOut) {
            self.TitleLabel.alpha = 1.0
            self.TitleInfoLabel.alpha = 1.0
            self.view.layoutIfNeeded()
        }
        animator3.startAnimation(afterDelay: 1.0)
    }

    func shakeButton() {
        let animation = CAKeyframeAnimation()
        animation.keyPath = "position.x"
        animation.values = [0, 10, -10, 10, 0]
        animation.keyTimes = [0, 0.16, 0.5, 0.83, 1]
        animation.duration = 0.4

        animation.isAdditive = true
        signInButton.layer.add(animation, forKey: "shake")
    }


}
