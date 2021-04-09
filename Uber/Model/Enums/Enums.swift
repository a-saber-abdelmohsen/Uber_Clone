//
//  Enums.swift
//  Uber
//
//  Created by Ahmed Saber on 07/04/2021.
//


enum ErrorMessages: Int, CustomStringConvertible {
    case emptyEmailorPassword
    case wrongEmail
    case emptyField
    case cannotLogOut
    case locationServicesDisables
    case locationServiceDenied
    
    var description: String {
        switch self {
        case .emptyEmailorPassword: return "Please Enter the Email and the Password"
        case .wrongEmail: return "Wrong Email or Password"
        case .emptyField: return "Please Fill In Empty Fields"
        case .cannotLogOut: return "Can't Log out Please Check The Internet Connection and Try Again"
        case .locationServiceDenied: return "Uber Needs Your Location to Find You Nearby Drivers\nGo TO: Settings > Privacy > Location Services"
        case .locationServicesDisables: return "Please Enable GPS to Use Uber"
        }
    }
}
