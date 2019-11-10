//
//  ChangePasswordViewModel.swift
//  AuthSample
//
//  Created by Susumu Hoshikawa on 2019/11/10.
//  Copyright © 2019 SH Lab, Inc. All rights reserved.
//

import Foundation
import Firebase
import Combine
import SwiftUI

class ChangePasswordViewModel: ObservableObject {
    
    @Published var password = ""
    @Published var confirmPassword = ""
        
    var validInput: Bool {
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
    
    func changePassword(mode: Binding<PresentationMode>) {
        print(#function)
        
        Auth.auth().currentUser?.updatePassword(to: self.password) { error in
            if let error = error {
                print("error = \(error.localizedDescription)")
                return
            }
            
            print("success change password !")
            mode.wrappedValue.dismiss()
        }
    }
}
