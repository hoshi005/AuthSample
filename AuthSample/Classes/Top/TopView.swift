//
//  TopView.swift
//  AuthSample
//
//  Created by Susumu Hoshikawa on 2019/11/02.
//  Copyright © 2019 SH Lab, Inc. All rights reserved.
//

import SwiftUI

struct TopView: View {
    
    @ObservedObject(initialValue: TopViewModel()) var viewModel
    
    @State var showSignUpModal = false
    @State var showSignInModal = false
    @State var showForgotPasswordModal = false
    @State var showChangePasswordModal = false
    @State var showUserInfoModal = false
    @State var showSignOutAlert = false
    
    var body: some View {
        VStack(spacing: 8.0) {
            // サインイン状態でビューを切り替える.
            if viewModel.isSiginIn {
                self.signInView
            } else {
                self.signOutView
            }
        }
        .onAppear {
            self.viewModel.setupHandler()
        }
        .onDisappear {
            self.viewModel.removeHandler()
        }
        .padding()
    }
}


extension TopView {
    
    var signOutView: some View {
        VStack {
            Button(action: {
                self.showSignUpModal.toggle()
            }) {
                HStack {
                    Image(systemName: "person.badge.plus.fill")
                        .imageScale(.large)
                    Text("ユーザ作成")
                }
            }
            .sheet(isPresented: $showSignUpModal) {
                CreateUserView()
            }
            
            Button(action: {
                self.showSignInModal.toggle()
            }) {
                HStack {
                    Image(systemName: "person.crop.circle.badge.plus")
                        .imageScale(.large)
                    Text("ログイン")
                }
            }
            .sheet(isPresented: $showSignInModal) {
                SignInView()
            }
            
            Button(action: {
                self.showForgotPasswordModal.toggle()
            }) {
                HStack {
                    Image(systemName: "lock.circle")
                        .imageScale(.large)
                    Text("パスワードをお忘れの方")
                }
            }
            .sheet(isPresented: $showForgotPasswordModal) {
                ForgotPasswordView()
            }
        }
    }
    
    var signInView: some View {
        VStack {
            // サインインユーザ情報.
            Group {
                Text("User Name: \(viewModel.userName)")
                Text("Email: \(viewModel.email)")
                Text("Email確認: \(viewModel.isEmailVerified ? "済" : "未")")
            }
            .font(.headline)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            // ユーザ名変更ボタン.
            Button(action: {
                self.showUserInfoModal.toggle()
            }) {
                HStack {
                    Image(systemName: "pencil.and.ellipsis.rectangle")
                        .imageScale(.large)
                    Text("ユーザ名の変更")
                }
            }
            .sheet(isPresented: $showUserInfoModal, onDismiss: {
                self.viewModel.setupUserInfo()
            }) {
                UserInfoView()
            }
            
            // パスワード変更ボタン.
            Button(action: {
                self.showChangePasswordModal.toggle()
            }) {
                HStack {
                    Image(systemName: "lock.rotation")
                        .imageScale(.large)
                    Text("パスワードを変更する")
                }
            }
            .sheet(isPresented: $showChangePasswordModal) {
                ChangePasswordView()
            }
            
            // ユーザ情報のリフレッシュボタン.
            Button(action: {
                self.viewModel.reloadUserInfo()
            }) {
                HStack {
                    Image(systemName: "arrow.clockwise.circle")
                        .imageScale(.large)
                    Text("ユーザ情報更新")
                }
            }
            
            // サインアウトボタン.
            Button(action: {
                self.showSignOutAlert.toggle()
            }) {
                HStack {
                    Image(systemName: "person.crop.circle.badge.minus")
                        .imageScale(.large)
                    Text("ログアウト")
                }
            }
            .alert(isPresented: $showSignOutAlert) {
                Alert(
                    title: .init("ログアウト"),
                    message: .init("ログアウトしても良いですか？"),
                    primaryButton: Alert.Button.cancel() {
                        print("Cancelタップ時の処理.")
                    },
                    secondaryButton: Alert.Button.destructive(.init("ログアウト")) {
                        self.viewModel.signOut()
                    }
                )
            }
        }
    }
}

struct TopView_Previews: PreviewProvider {
    static var previews: some View {
        TopView()
    }
}
