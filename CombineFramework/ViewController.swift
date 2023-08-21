//
//  ViewController.swift
//  CombineFramework
//
//  Created by Mac on 21/08/2023.
//

import UIKit
import Combine
class ViewController: UIViewController {
    
    var viewModel = LoginViewModel()
    var cancellables = Set<AnyCancellable>()
    let networkService = NetworkService() // Create an instance of NetworkService

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.isLoginButtonEnabled
              .receive(on: DispatchQueue.main)
              .assign(to: \.isEnabled, on: loginButton)
              .store(in: &cancellables)
          
          usernameTextField.publisher(for: \.text)
              .sink { [weak self] text in
                  self?.viewModel.username = text ?? ""
               }
              .store(in: &cancellables)
          
          passwordTextField.publisher(for: \.text)
              .sink { [weak self] text in
                  self?.viewModel.password = text ?? ""
              }
              .store(in: &cancellables)
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    @IBAction func loginAction(_ sender: UIButton) {
        viewModel.performLogin(networkService)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                // Handle completion (if needed)
            }, receiveValue: { isSuccess in
                if isSuccess {
                    print("Success")
                    // Perform navigation or show success message
                } else {
                    print("Failed")
                    // Show error message or handle failed login
                }
            })
            .store(in: &cancellables)
    }
}
