//
//  CreateUserView.swift
//  AuthSample
//
//  Created by Susumu Hoshikawa on 2019/11/02.
//  Copyright © 2019 SH Lab, Inc. All rights reserved.
//

import SwiftUI

struct CreateUserView: View {
    
    @ObservedObject(initialValue: CreateUserViewModel()) var viewModel
    
    var body: some View {
        NavigationView {
            VStack {
                
                TextField("User Name.", text: $viewModel.userName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .border(Color.gray, width: 2)
                
                TextField("your Email Address.", text: $viewModel.email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.emailAddress)
                    .border(Color.gray, width: 2)
                
                SecureField("password.", text: $viewModel.password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .border(Color.gray, width: 2)
                
                SecureField("confirm password.", text: $viewModel.confirmPassword)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .border(Color.gray, width: 2)
                
                Button(action: {
                    self.viewModel.createUser()
                }) {
                    HStack {
                        Image(systemName: "person.badge.plus.fill")
                            .imageScale(.large)
                        Text("アカウントを作成する")
                    }
                }
                .disabled(!viewModel.validInput)
                .padding()
                
                Spacer()
            }
            .padding()
            .navigationBarTitle(.init("サインアップ"))
        }
    }
}

struct CreateUserView_Previews: PreviewProvider {
    static var previews: some View {
        CreateUserView()
    }
}
