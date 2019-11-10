//
//  SignInViewModel.swift
//  AuthSample
//
//  Created by Susumu Hoshikawa on 2019/11/02.
//  Copyright © 2019 SH Lab, Inc. All rights reserved.
//

import Foundation
import Firebase

class SignInViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    
    var validInput: Bool {
        !email.isEmpty && !password.isEmpty
    }
    
    func signin(completion handler: @escaping () -> ()) {
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let self = self else { return }
            
            if let user = authResult?.user {
                print("ログイン成功：: \(user)")
                handler()
            }
            
            self.showError(error)
        }
    }
}

extension SignInViewModel {

    private func showError(_ errorOrNil: Error?) {
        guard let error = errorOrNil else { return }
        print(error)
    }
}
