//
//  TopViewModel.swift
//  AuthSample
//
//  Created by Susumu Hoshikawa on 2019/11/02.
//  Copyright © 2019 SH Lab, Inc. All rights reserved.
//

import Foundation
import Firebase

class TopViewModel: ObservableObject {
    
    var handle: AuthStateDidChangeListenerHandle?
    
    @Published var userName = ""
    @Published var email = ""
    @Published var isEmailVerified = false
    @Published var isSiginIn = false
    
    func setupUserInfo() {
        print(#function)
        
        if let user = Auth.auth().currentUser {
            print("ユーザ情報取得: \(user)")
            self.userName = user.displayName ?? "(no data)"
            self.email = user.email ?? "(no data)"
            self.isEmailVerified = user.isEmailVerified
        } else {
            print("未ログイン")
            self.userName = ""
            self.email = ""
            self.isEmailVerified = false
        }
        
        self.isSiginIn = Auth.auth().currentUser != nil
    }
    
    func setupHandler() {
        print(#function)
        
        handle = Auth.auth().addStateDidChangeListener { auth, user in
            print("### ユーザ情報に変更あり. ###")
            self.setupUserInfo()
        }
    }
    
    /// 最新のユーザ情報を取得する.
    func reloadUserInfo() {
        if let user = Auth.auth().currentUser {
            user.reload { [weak self] error in
                guard let self = self else { return }
                if let error = error {
                    print("error = \(error.localizedDescription)")
                    return
                }
                self.setupUserInfo()
            }
        }
    }
    
    func removeHandler() {
        print(#function)
        
        if let handle = handle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
    
    func signOut() {
        print(#function)
        do {
            try Auth.auth().signOut()
        } catch {
            print(error)
        }
    }
}
