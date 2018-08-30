//
//  ViewController.swift
//  WorldTrotter
//
//  Created by Mohanad Alhayek on 8/28/18.
//  Copyright © 2018 Mohanad Alhayek. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var celsiusLabel: UILabel!
    @IBOutlet var textField: UITextField!
    
    let numberFormatter : NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    }()
    var fahrenheitValue : Measurement<UnitTemperature>?{
        didSet{
            updateCelsiusLabel()
        }
    }
    var celsiusValue : Measurement<UnitTemperature>?{
        if let f = self.fahrenheitValue {
            return f.converted(to: .celsius)
        }else{
            return nil
        }
    }
    func updateCelsiusLabel(){
        if let c = celsiusValue{
   //         self.celsiusLabel.text = "\(c.value)"
            self.celsiusLabel.text = numberFormatter.string(from: NSNumber(value : c.value))
        }else{
            self.celsiusLabel.text = "???"
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        updateCelsiusLabel()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
          self.textField.resignFirstResponder()
        
    }
    @IBAction func updatedDegree(_ sender: Any) {
        // at this point if this empty, then avoid NullpointerExcpetion
        if let text = textField.text, let v = Double(text) {
          //  self.celsiusLabel.text = self.textField.text
            self.fahrenheitValue = Measurement(value: v, unit : .fahrenheit)
        }else{
            self.celsiusLabel.text = "???"
        }
    }
    // after we set up delegation , for the txt this method is being called everytimes changes are made on the textfield
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        print("Replacement : \(string)")
//        print("Current : \(textField.text)")
        let existingDecimal = textField.text?.range(of: ".")
        let replacementDecimal = string.range(of: ".")
        if existingDecimal != nil && replacementDecimal != nil{
            return false
        }else{
            return true
        }
        
    }
}

