//
//  ForgotPasswordView.swift
//  AuthSample
//
//  Created by Susumu Hoshikawa on 2019/11/04.
//  Copyright © 2019 SH Lab, Inc. All rights reserved.
//

import SwiftUI

struct ForgotPasswordView: View {
    
    @ObservedObject(initialValue: ForgotPasswordViewModel()) var viewModel
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("your Email Address.", text: $viewModel.email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.emailAddress)
                    .border(Color.gray, width: 2)
                
                Button(action: {
                    self.viewModel.sendMail {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }) {
                    HStack {
                        Image(systemName: "lock.circle")
                            .imageScale(.large)
                        Text("メールを送信する")
                    }
                }
                .disabled(!viewModel.validInput)
                .padding()
                
                Spacer()
            }
            .padding()
            .navigationBarTitle(.init("パスワード忘れ"))
        }
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}
