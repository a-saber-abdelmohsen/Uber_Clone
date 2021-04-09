//
//  User.swift
//  Uber
//
//  Created by Ahmed Saber on 06/04/2021.
//

struct User {
    var fullName: String
    var email: String
    var accountType: AccountType
    
    
    init(dictionary: [String: Any]) {
        fullName = dictionary["fullName"] as? String ?? ""
        email = dictionary["email"] as? String ?? ""
        accountType = AccountType(rawValue: dictionary["accountType"] as? Int ?? 0) ?? AccountType.Rider
        print("DEBUG: \(accountType)")
    }
}
