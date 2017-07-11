//
//  GeneratePasswordViewController.swift
//  password-manager
//
//  Created by sk-153353 on 11.07.17.
//  Copyright © 2017 sk-ed. All rights reserved.
//

import Foundation
import UIKit

class GeneratePasswordViewController : UIViewController{

    public var SelectedPassword : Password?;
    @IBOutlet var LabelLength: UILabel!
    @IBOutlet var SwitchUpperCase: UISwitch!
    @IBOutlet var SwitchLowerCase: UISwitch!
    @IBOutlet var SwitchNumbers: UISwitch!
    @IBOutlet var SwitchSpecialCharacters: UISwitch!
    @IBOutlet var LabelOutputPassword: UILabel!
    @IBOutlet var ButtonTake: UIButton!
    @IBOutlet var SliderLength: UISlider!
    
    
    @IBAction func SliderLengthValueChanged(_ sender: Any) {
        LabelLength.text = "Länge: \(Int(SliderLength.value))";

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Passwort generieren"
        
        LabelLength.text = "Länge: \(Int(SliderLength.value))";
        LabelOutputPassword.text = "";
        ButtonTake.isHidden = true;
    }
    
    @IBAction func ButtonGeneratePasswordClicked(_ sender: Any) {
        
        let useUpper = SwitchUpperCase.isOn;
        let useLower = SwitchLowerCase.isOn;
        let useNumbers = SwitchNumbers.isOn;
        let useSpecial = SwitchSpecialCharacters.isOn;
        
        if(!useUpper && !useLower && !useNumbers && !useSpecial) {
            return;
        }
        
        
        let random = RandomPassword();
        random.useUpperCase(useUpper);
        random.useLowerCase(useLower);
        random.useNumbers(useNumbers);
        random.useSpeciaCharaters(useSpecial);
        
        let randomPassword = random.getPassword(length: Int32(Int(SliderLength.value)));
        LabelOutputPassword.text = randomPassword;
        ButtonTake.isHidden = false;
    }
    
    @IBAction func ButtonTakeClicked(_ sender: Any) {
        SelectedPassword?.password = LabelOutputPassword.text;
        
        _ = navigationController?.popViewController(animated: true)
    }
    
}
