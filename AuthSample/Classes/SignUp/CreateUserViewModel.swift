//
//  CreateUserViewModel.swift
//  AuthSample
//
//  Created by Susumu Hoshikawa on 2019/11/02.
//  Copyright © 2019 SH Lab, Inc. All rights reserved.
//

import Combine
import Firebase

class CreateUserViewModel: ObservableObject {
    
    @Published var userName = ""
    @Published var email = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    
    var validInput: Bool {
        
        if userName.isEmpty {
            return false
        }
        if email.isEmpty {
            return false
        }
        if password.isEmpty {
            return false
        }
        if confirmPassword.isEmpty {
            return false
        }
        if password != confirmPassword {
            return false
        }
        return true
    }
    
    func createUser() {
        print(#function)
        
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            guard let self = self else { return }
            
            if let user = authResult?.user {
                self.updateDisplayName(self.userName, of: user)
            }
            
            self.showError(error)
        }
    }
}

extension CreateUserViewModel {
    
    private func updateDisplayName(_ name: String, of user: User) {
        print(#function)
        
        let request = user.createProfileChangeRequest()
        request.displayName = name
        request.commitChanges { [weak self] error in
            guard let self = self else { return }
            if error == nil {
                self.sendEmailVarification(to: user)
            }
            self.showError(error)
        }
    }
    
    private func sendEmailVarification(to user: User) {
        print(#function)
        
        user.sendEmailVerification { [weak self] error in
            guard let self = self else { return }
            if error == nil {
                self.showSignUpCompletion()
            }
            self.showError(error)
        }
    }
    
    private func showSignUpCompletion() {
        print(#function)
    }
    
    private func showError(_ errorOrNil: Error?) {
        guard let error = errorOrNil else { return }
        print(error)
    }
}
