//
//  UserDefaults+Extension.swift
//  Seehyang-iOS
//
//  Created by JeongMinho on 2021/11/23.
//

import Foundation

@propertyWrapper
struct UserDefault<T> {
    let key: String
    let defaultValue: T
    
    var wrappedValue: T {
        get {
            return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}

extension UserDefaults {
    @UserDefault(key: "onboardingIsNeeded", defaultValue: true)
    static var onboardingIsNeeded: Bool
}
