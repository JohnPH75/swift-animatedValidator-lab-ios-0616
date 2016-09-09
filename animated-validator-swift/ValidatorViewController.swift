//
//  ValidatorViewController.swift
//  animated-validator-swift
//
//  Created by Flatiron School on 6/27/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ValidatorViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailConfirmationTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordConfirmTextField: UITextField!
    
    @IBOutlet weak var submitButtonCenterYConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view, typically from a nib.
        self.submitButton.accessibilityLabel = Constants.SUBMITBUTTON
        self.emailTextField.accessibilityLabel = Constants.EMAILTEXTFIELD
        self.emailConfirmationTextField.accessibilityLabel = Constants.EMAILCONFIRMTEXTFIELD
        self.phoneTextField.accessibilityLabel = Constants.PHONETEXTFIELD
        self.passwordTextField.accessibilityLabel = Constants.PASSWORDTEXTFIELD
        self.passwordConfirmTextField.accessibilityLabel = Constants.PASSWORDCONFIRMTEXTFIELD
        
        self.submitButton.enabled = false
        
        
        
        self.emailTextField.delegate = self
        self.emailConfirmationTextField.delegate = self
        self.phoneTextField.delegate = self
        self.passwordTextField.delegate = self
        self.passwordConfirmTextField.delegate = self
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        
        isValidText(textField)
        
    }
    
    func isValidText(textField: UITextField){
        
        let validText = textField.text!.characters.count > 0
        
        let validEmail = self.emailTextField.text!.containsString("@") && self.emailTextField.text!.containsString(".")
        
        let validEmailConfirm = self.emailConfirmationTextField.text == self.emailTextField.text && self.emailConfirmationTextField.text!.characters.count > 0
        
        let validPhone = self.phoneTextField.text?.characters.count >= 7
        
        let validPassword = self.passwordTextField.text?.characters.count >= 6
        
        let validPasswordConfirm = self.passwordConfirmTextField.text == self.passwordTextField.text && self.passwordConfirmTextField.text?.characters.count > 0
        
        
        switch textField {
            
        case emailTextField:
            
            if validText && validEmail {
                
                self.emailTextField.backgroundColor = UIColor.whiteColor()
                
            }else{
                
                pulseTextField(emailTextField)
                
            }
            
        case emailConfirmationTextField:
            
            if validEmailConfirm && validEmail{
                
                self.emailConfirmationTextField.backgroundColor = UIColor.whiteColor()
            }else{
                pulseTextField(self.emailConfirmationTextField)
                
            }

            
        case phoneTextField:
            
            if  validPhone{
                
                self.phoneTextField.backgroundColor = UIColor.whiteColor()
            }else{
                pulseTextField(self.phoneTextField)
            }
            
        case passwordTextField :
            
            if  validPassword{
                
                self.passwordTextField.backgroundColor = UIColor.whiteColor()
            }else{
                
                pulseTextField(passwordTextField)
            }
            
            
        case passwordConfirmTextField:
            
            if validPasswordConfirm && validPassword{
                
                self.passwordConfirmTextField.backgroundColor = UIColor.whiteColor()
            }else{
                
                pulseTextField(passwordConfirmTextField)
            }
        default: break
        }
        
        if validPasswordConfirm && validPassword && validPhone && validEmailConfirm && validEmail && validText {
            moveButton()
        }
    }
    
    func moveButton(){
        
        UIView.animateWithDuration(1) {
            
            self.submitButtonCenterYConstraint.constant = -33
            
            self.view.layoutIfNeeded()
            
            self.submitButton.enabled = true
            
        }
        
    }
    
    func pulseTextField(textField: UITextField) {
        
        
        UIView.animateWithDuration(0.33, delay: 0.0, options: [.Repeat, .Autoreverse], animations: {
            
            UIView.setAnimationRepeatCount(3.0)
            textField.transform = CGAffineTransformMakeScale(0.98, 0.98)
            textField.backgroundColor = UIColor.redColor()
            self.view.layoutIfNeeded()
            
        }) { (true) in
            textField.transform = CGAffineTransformMakeScale(1.0, 1.0)
            
        }
        
    }

}