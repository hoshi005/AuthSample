//
//  UserInfoViewModel.swift
//  AuthSample
//
//  Created by Susumu Hoshikawa on 2019/11/10.
//  Copyright © 2019 SH Lab, Inc. All rights reserved.
//

import Foundation
import Firebase

class UserInfoViewModel: ObservableObject {
    
    @Published var displayName: String
    
    var validInput: Bool {
        !displayName.isEmpty
    }
    
    init() {
        self.displayName = Auth.auth().currentUser?.displayName ?? ""
    }
    
    func updateDisplayName(completion handler: @escaping () -> ()) {
        print(#function)
        
        guard let user = Auth.auth().currentUser else { return }
        
        let request = user.createProfileChangeRequest()
        request.displayName = self.displayName
        request.commitChanges { error in
            if let error = error {
                print("error = \(error.localizedDescription)")
                return
            }
            
            print("display name 成功")
            print("user = \(user.displayName ?? "no data !")")
            
            handler()
        }
    }
}
