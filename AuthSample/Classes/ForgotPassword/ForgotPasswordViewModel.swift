//
//  ForgotPasswordViewModel.swift
//  AuthSample
//
//  Created by Susumu Hoshikawa on 2019/11/04.
//  Copyright © 2019 SH Lab, Inc. All rights reserved.
//

import Foundation
import Firebase

class ForgotPasswordViewModel: ObservableObject {
    
    @Published var email = ""
    
    var validInput: Bool {
        !email.isEmpty
    }
    
    func sendMail(completion handler: @escaping () -> ()) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                print("error = \(error.localizedDescription)")
                return
            }
            
            print("送信成功.")
            handler()
        }
    }
}
