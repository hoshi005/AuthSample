//
//  ChangeEmailViewModel.swift
//  AuthSample
//
//  Created by Susumu Hoshikawa on 2019/11/10.
//  Copyright © 2019 SH Lab, Inc. All rights reserved.
//

import Foundation
import Firebase

class ChangeEmailViewModel: ObservableObject {
    
    @Published var email = ""
    
    var validInput: Bool {
        !email.isEmpty
    }
    
    func updateEmail(completion handler: @escaping () -> ()) {
        print(#function)
        
        Auth.auth().currentUser?.updateEmail(to: self.email) { error in
            if let error = error {
                print("error = \(error.localizedDescription)")
                return
            }
            print("### change Email.")
            handler()
        }
    }
}
