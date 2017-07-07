//
//  RandomPassword.swift
//  password-manager
//
//  Created by ed-153020 on 07/07/2017.
//  Copyright © 2017 sk-ed. All rights reserved.
//

import Foundation


//https://stackoverflow.com/questions/41730933/random-password-generator-swift-3
class RandomPassword
{
    //all characters which are allowed for generating a password will be append here
    var allowedCharacters = Array<Character>();
    
    
    //the password will now made use of lower case letters
    public func useLowerCase()
    {
        allowedCharacters += Array("abcdefghijklmnopqrstuvwxyz".characters);
    }
    
    //the password will now made use of upper case letters
    public func useUpperCase()
    {
        allowedCharacters += Array("ABCDEFGHIJKLMNOPQRSTUVWXYZ".characters);
    }
    
    //the password will now made use of numbers
    public func useNumbers()
    {
        allowedCharacters += Array("1234567890".characters);
    }
    
    //the password will now made use of special charaters
    public func useSpeciaCharaters()
    {
        allowedCharacters += Array("!\"\\$%&/()=?[]{}*+#'-_.:,;".characters);
    }
    
    //generates finally the password
    public func getPassword(length: Int32) -> String
    {
        var password = "";
        
        for _ in 0..<length {
            // generate a random index based on your array of characters count
            let rand = arc4random_uniform(UInt32(allowedCharacters.count))
            // append the random character to your string
            password.append(allowedCharacters[Int(rand)])
        }
        
        return password;
    }
}
