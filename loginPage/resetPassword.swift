//
//  resetPassword.swift
//  loginPage
//
//  Created by Jason Leung on 24/9/2020.
//

import SwiftUI

struct resetPassword: View {
    
    @State var new_password: String = ""
    @State var confirm_password: String = ""
    @State var reset = false
    
    func validator() -> Void {
        if (new_password != "" && confirm_password != "") {
            if (new_password != confirm_password) {
                self.reset = false
            } else {
                test_password = new_password
                self.reset = true
            }
        } else {
            self.reset = false
        }
    }
    
    var body: some View {
            VStack {
                VStack {
                    SecureField("New Password", text: $new_password)
                        .padding()
                        .background(lightGreyColor)
                        .cornerRadius(5.0)
                    SecureField("Confirm Password", text: $confirm_password)
                        .padding()
                        .background(lightGreyColor)
                        .cornerRadius(5.0)
                        .padding(.bottom, 20)
                    NavigationLink(
                        destination: loginSuccessful(),
                        isActive: $reset,
                        label: {
                            Button(action: {validator()}, label: {
                                Text("Submit")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(width: 110, height: 40)
                                    .background(Color.green)
                                    .cornerRadius(15.0)
                            })
                                
                        })
                }
                .padding()
                Spacer()
            }.navigationBarTitle(Text("Reset Password"), displayMode: .inline)
    }
}

struct resetPassword_Previews: PreviewProvider {
    static var previews: some View {
        resetPassword()
    }
}
