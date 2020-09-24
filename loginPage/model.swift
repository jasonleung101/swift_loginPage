//
//  model.swift
//  loginPage
//
//  Created by Jason Leung on 24/9/2020.
//

import Foundation

class UserInput: ObservableObject {
    @Published var username: String = ""
    @Published var password: String = ""
}
