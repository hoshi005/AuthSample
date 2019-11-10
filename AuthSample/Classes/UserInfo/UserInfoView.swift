//
//  UserInfoView.swift
//  AuthSample
//
//  Created by Susumu Hoshikawa on 2019/11/10.
//  Copyright © 2019 SH Lab, Inc. All rights reserved.
//

import SwiftUI

struct UserInfoView: View {
    
    @ObservedObject(initialValue: UserInfoViewModel()) var viewModel
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("change display name.", text: $viewModel.displayName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .border(Color.gray, width: 2)
                
                Button(action: {
                    self.viewModel.updateDisplayName(mode: self.presentationMode)
                }) {
                    HStack {
                        Image(systemName: "person")
                            .imageScale(.large)
                        Text("ユーザ名を変更する")
                    }
                }
                .disabled(!viewModel.validInput)
                .padding()
                
                Spacer()
            }
            .padding()
            .navigationBarTitle(.init("ユーザ名変更"))
        }
    }
}

struct UserInfoView_Previews: PreviewProvider {
    static var previews: some View {
        UserInfoView()
    }
}
