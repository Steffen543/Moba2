//
//  GeneralHelper.swift
//  password-manager
//
//  Created by ed-153020 on 10.07.17.
//  Copyright © 2017 sk-ed. All rights reserved.
//

import Foundation
import UIKit

class GeneralHelper {
    //https://stackoverflow.com/questions/27987048/shake-animation-for-uitextfield-uiview-in-swift
    public static func shakeElement(field: UIView) {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation.duration = 0.6
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        field.layer.add(animation, forKey: "shake")
    }
}
