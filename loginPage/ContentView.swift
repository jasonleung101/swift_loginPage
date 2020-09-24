//
//  ContentView.swift
//  loginPage
//
//  Created by Jason Leung on 24/9/2020.
//

import SwiftUI
import SwiftKeychainWrapper

let lightGreyColor = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0)

var test_password: String = "esdlife"

struct ContentView: View {
    @State var username: String = ""
    @State var password: String = ""
    @State var login = false
    @State var index = 0
    @State private var showAlert = false
    @State private var showUsernameAlert = false
    @State private var savedPW = false
    @State private var wrongPwd = false

    var images = ["dummy1", "dummy2", "dummy1"]
    
    let retrievedString: String? = KeychainWrapper.standard.string(forKey: "username")
    let retrievedPassword: String? = KeychainWrapper.standard.string(forKey: "password")
    
    func loginCheck() -> Void {
        
        if (username == "") {
            showUsernameAlert = true
            return
        }
        
        KeychainWrapper.standard.set(username, forKey: "username")
        
        let toLoginPwd: String? = KeychainWrapper.standard.string(forKey: "password")
        
        // check password was save or not
        if (toLoginPwd != "" && toLoginPwd != nil) {
            print(toLoginPwd as Any)
            if (toLoginPwd != password) {
                self.showAlert = true
            } else {
//                self.showAlert = false
                loginValidate()
            }
        } else {
            if (password != "") {
                self.showAlert = true
            }
        }
    }
    
    func loginValidate() -> Void {
        print("username: " + username.lowercased())
        print("password: " + password)
        
        // check username and password
        if (username.lowercased() == "jasonleung" && password == test_password) {
            self.login = true
        } else {
            self.login = false
            self.wrongPwd = true
            clearValue()
        }
    }
    
    func clearValue() -> Void {
        self.password = ""
    }
    
    func autoFill() -> Void {
        if (retrievedString != nil) {
            username = retrievedString ?? ""
        }
        if (retrievedPassword != nil) {
            password = retrievedPassword ?? ""
            if (username == "") {
                clearValue()
            }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    UserImage()
                    TextField("Username", text: $username)
                        .autocapitalization(.none)
                        .padding()
                        .background(lightGreyColor)
                        .cornerRadius(5.0)
                        .padding(.bottom, 20)
                        .onAppear(perform: {
                            autoFill()
                        })
                        .alert(isPresented: $showUsernameAlert) {
                            () -> Alert in
                            return Alert(title: Text("Please fill in username"), dismissButton: Alert.Button.default(Text("OK")))
                        }
                    SecureField("Password", text: $password)
                        .padding()
                        .background(lightGreyColor)
                        .cornerRadius(5.0)
                        .alert(isPresented: $wrongPwd) {
                            () -> Alert in
                            return Alert(title: Text("Wrong Password"), dismissButton: Alert.Button.default(Text("OK")))
                        }
                    NavigationLink(
                        destination: resetPassword(),
                        label: {
                            ForgetPasswordContent()
                                .padding(.bottom, 30)
                        })
                    
                    NavigationLink(
                        destination: loginSuccessful(),
                        isActive: $login,
                        label: {
                            EmptyView()
                        })
                        .onDisappear(perform: clearValue)
                    Button(action: {self.loginCheck()}) {
                       LoginButtonContent()
                    }
                }
                .padding()
                .navigationBarTitle("Welcome")
                
                Spacer()
                
                PagingView(index: $index.animation(), maxIndex: (images.count - 1)) {
                    ForEach(self.images, id: \.self) {
                        imageName in Image(imageName)
                            .resizable()
                            .scaledToFill()
                    }
                }
                .frame(width: UIScreen.main.bounds.width, height: 100)
                
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .alert(isPresented: $showAlert) {
            () -> Alert in
            return Alert(title: Text("Save Password?"), primaryButton: Alert.Button.default(Text("Yes"), action: {
                KeychainWrapper.standard.removeObject(forKey: "password")
                KeychainWrapper.standard.set(self.password, forKey: "password")
                loginValidate()
            }), secondaryButton: Alert.Button.destructive(Text("No"), action: {loginValidate()}))
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 11")
    }
}

struct WelcomeText: View {
    var body: some View {
        Text("Welcome")
            .font(.largeTitle)
            .fontWeight(.semibold)
            .padding(.bottom, 20)
    }
}

struct UserImage: View {
    var body: some View {
        Image("userImage")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 150, height: 150)
            .clipped()
            .cornerRadius(150)
            .overlay(RoundedRectangle(cornerRadius: 150)
                        .stroke(Color.gray, lineWidth: 2))
            .padding(.bottom, 35)
    }
}

struct LoginButtonContent: View {
    var body: some View {
        Text("LOGIN")
            .font(.headline)
            .fontWeight(.bold)
            .foregroundColor(.white)
            .padding()
            .frame(width: 220, height: 60)
            .background(Color.green)
            .cornerRadius(15.0)
    }
}

struct ForgetPasswordContent: View {
    var body: some View {
        HStack {
            Spacer()
            Text("Forget password?")
                .font(.footnote)
                .foregroundColor(.gray)
                .fontWeight(.light)
        }
    }
}

//func loginValidate(username: String, password: String) -> Bool {
//    print("username" + username)
//    print("password" + password)
//    if (username == "jasonleung" && password == test_password) {
//        print("login successfully")
//        return true
//    } else {
//        print("login failed")
//        return false
//    }
//}
