//
//  LoginViewModel.swift
//  CombineFramework
//
//  Created by Mac on 21/08/2023.
//

import Foundation
import Combine

class LoginViewModel {
    @Published var username: String = ""
    @Published var password: String = ""
    
    var isLoginButtonEnabled: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest($username, $password)
            .map { username, password in
                return !(username.isEmpty) && !(password.isEmpty)
            }
            .eraseToAnyPublisher()
    }
    
    func performLogin(_ servce:NetworkService) -> AnyPublisher<Bool, Error> {
 
        return servce.login(username: username, password: password)
    }
}
