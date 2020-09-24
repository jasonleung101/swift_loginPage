//
//  loginSuccessful.swift
//  loginPage
//
//  Created by Jason Leung on 24/9/2020.
//

import SwiftUI

struct loginSuccessful: View {
    var body: some View {
            VStack {
                Text("Successful login")
                    .padding(.bottom, 20)
                NavigationLink(
                    destination: ContentView(),
                    label: {
                        logoutBtn()
                    })
                }
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
        }
}

struct loginSuccessful_Previews: PreviewProvider {
    static var previews: some View {
        loginSuccessful()
    }
}

struct logoutBtn: View {
    var body: some View {
        Text("Logout")
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(width: 110, height: 40)
            .background(Color.red)
            .cornerRadius(15.0)
    }
}
