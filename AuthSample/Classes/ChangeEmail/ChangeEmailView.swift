//
//  ChangeEmailView.swift
//  AuthSample
//
//  Created by Susumu Hoshikawa on 2019/11/10.
//  Copyright © 2019 SH Lab, Inc. All rights reserved.
//

import SwiftUI

struct ChangeEmailView: View {
    
    @ObservedObject(initialValue: ChangeEmailViewModel()) var viewModel
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Email Address.", text: $viewModel.email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.emailAddress)
                    .border(Color.gray, width: 2)
                
                Button(action: {
                    self.viewModel.updateEmail {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }) {
                    HStack {
                        Image(systemName: "envelope.circle")
                            .imageScale(.large)
                        Text("メールアドレスを変更する")
                    }
                }
                .disabled(!viewModel.validInput)
                .padding()
                
                Spacer()
            }
            .padding()
            .navigationBarTitle(.init("メールアドレス変更"))
        }
    }
}

struct ChangeEmailView_Previews: PreviewProvider {
    static var previews: some View {
        ChangeEmailView()
    }
}
