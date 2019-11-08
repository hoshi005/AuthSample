//
//  ForgotPasswordViewModel.swift
//  AuthSample
//
//  Created by Susumu Hoshikawa on 2019/11/04.
//  Copyright © 2019 SH Lab, Inc. All rights reserved.
//

import Combine
import Firebase
import SwiftUI

class ForgotPasswordViewModel: ObservableObject {
    
    @Published var email = ""
    
    var validInput: Bool {
        !email.isEmpty
    }
    
    func sendMail(mode: Binding<PresentationMode>) {
        Auth.auth().sendPasswordReset(withEmail: email) { [weak self] error in
            guard let self = self else { return }
            if let error = error {
                print("error = \(error.localizedDescription)")
                return
            }
            
            print("送信成功.")
            mode.wrappedValue.dismiss()
        }
    }
}
