//
//  ChangePasswordView.swift
//  AuthSample
//
//  Created by Susumu Hoshikawa on 2019/11/10.
//  Copyright © 2019 SH Lab, Inc. All rights reserved.
//

import SwiftUI

struct ChangePasswordView: View {
    
    @ObservedObject(initialValue: ChangePasswordViewModel()) var viewModel
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack {
                
                SecureField("password.", text: $viewModel.password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .border(Color.gray, width: 2)
                
                SecureField("confirm password.", text: $viewModel.confirmPassword)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .border(Color.gray, width: 2)
                
                Button(action: {
                    self.viewModel.changePassword(mode: self.presentationMode)
                }) {
                    HStack {
                        Image(systemName: "lock.rotation")
                            .imageScale(.large)
                        Text("パスワードを変更する")
                    }
                }
                .disabled(!viewModel.validInput)
                .padding()
                
                Spacer()
            }
            .padding()
            .navigationBarTitle(.init("パスワード変更"))
        }
    }
}

struct ChangePasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ChangePasswordView()
    }
}
