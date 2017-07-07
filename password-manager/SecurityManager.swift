//
//  SecurityManager.swift
//  password-manager
//
//  Created by ed-153020 on 07/07/2017.
//  Copyright © 2017 sk-ed. All rights reserved.
// https://stackoverflow.com/questions/25513106/trying-to-use-keychainitemwrapper-by-apple-translated-to-swift

import UIKit
import Security

class SecurityManager
{
    static let kSecClassGenericPasswordValue = String(format: kSecClassGenericPassword as String)
    static let kSecClassValue = String(format: kSecClass as String)
    static let kSecAttrServiceValue = String(format: kSecAttrService as String)
    static let kSecValueDataValue = String(format: kSecValueData as String)
    static let kSecMatchLimitValue = String(format: kSecMatchLimit as String)
    static let kSecReturnDataValue = String(format: kSecReturnData as String)
    static let kSecMatchLimitOneValue = String(format: kSecMatchLimitOne as String)
    static let kSecAttrAccountValue = String(format: kSecAttrAccount as String)
    
    
    //sets or creates a passwort into the keycain
    public static func setPasscode(identifier: String, passcode: String)
    {
        if let dataFromString = passcode.data(using: String.Encoding.utf8) {
            let keychainQuery = [
                kSecClassValue: kSecClassGenericPasswordValue,
                kSecAttrServiceValue: identifier,
                kSecValueDataValue: dataFromString
                ] as CFDictionary
            SecItemDelete(keychainQuery)
            print(SecItemAdd(keychainQuery, nil))
        }
    }
    
    //returns a password from the keychain
    public static func getPasscode(identifier: String) -> String?
    {
        let keychainQuery = [
            kSecClassValue: kSecClassGenericPasswordValue,
            kSecAttrServiceValue: identifier,
            kSecReturnDataValue: kCFBooleanTrue,
            kSecMatchLimitValue: kSecMatchLimitOneValue
            ] as  CFDictionary
        var dataTypeRef: AnyObject?
        let status: OSStatus = SecItemCopyMatching(keychainQuery, &dataTypeRef)
        var passcode: String?
        
        if (status == errSecSuccess) {
            if let retrievedData = dataTypeRef as? Data,
                let result = String(data: retrievedData, encoding: String.Encoding.utf8) {
                passcode = result as String
            }
        }
        else {
            print("Nothing was retrieved from the keychain. Status code \(status)")
        }
        return passcode
    }
}











