//
//  SignInView.swift
//  AuthSample
//
//  Created by Susumu Hoshikawa on 2019/11/02.
//  Copyright © 2019 SH Lab, Inc. All rights reserved.
//

import SwiftUI

struct SignInView: View {
    
    @ObservedObject(initialValue: SignInViewModel()) var viewModel
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("your Email Address.", text: $viewModel.email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.emailAddress)
                    .border(Color.gray, width: 2)
                
                SecureField("password.", text: $viewModel.password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .border(Color.gray, width: 2)
                
                Button(action: {
                    self.viewModel.signin {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }) {
                    HStack {
                        Image(systemName: "person.badge.plus.fill")
                            .imageScale(.large)
                        Text("ログインする")
                    }
                }
                .disabled(!viewModel.validInput)
                .padding()
                
                Spacer()
            }
            .padding()
            .navigationBarTitle(.init("ログイン"))
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
