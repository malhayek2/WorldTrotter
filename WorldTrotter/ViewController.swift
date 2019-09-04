//
//  ViewController.swift
//  WorldTrotter
//
//  Created by Mohanad Alhayek on 8/28/19.
//  Copyright © 2019 Mohanad Alhayek. All rights reserved.
//

import UIKit
// after adding a delegate (UITextFieldDelegate) you may need to add a protocal in the class declation
// this is just like an interface where its an abststract class that has set methods
// those methods need to be implemented.
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
    //declaring a collection of UnitTemperature.
    var fahrenheitValue : Measurement<UnitTemperature>?{
        // this is called "Computed Property" a data member that changes based on code.
        // property observer, keeps an eye on the var if it change.
        didSet{
            updateCelsiusLabel()
        }
    }
    // declaring a collection for Celsius
    var celsiusValue : Measurement<UnitTemperature>?{
        // if let,this means that we are unwrapping.
        if let f = fahrenheitValue {
            return f.converted(to: .celsius)
        }else{
            return nil
        }
    }
    // this function will be called within the FahrenhitValue
    func updateCelsiusLabel(){
        if let c = celsiusValue{
            
   //         self.celsiusLabel.text = "\(c.value)"
            celsiusLabel.text = numberFormatter.string(from: NSNumber(value : c.value))
        }else{
            celsiusLabel.text = "???"
        }
    }
    override func viewDidLoad() {
        print("viewController loaded")
        super.viewDidLoad()
        updateCelsiusLabel()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //this fucntion dismisses the keyborad when tapping away.
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
          textField.resignFirstResponder()
        
    }
    @IBAction func updatedDegree(_ sender: Any) {
        // at this point if this empty, then avoid NullpointerExcpetion
        //note that Double(Text) is called double constructor
        if let text = textField.text, let v = Double(text) {
            fahrenheitValue = Measurement(value: v, unit : UnitTemperature.fahrenheit)
        }else{
            //celsiusLabel.text = "???"
            fahrenheitValue = nil
        }
    }
    // delegator(commands an action) tends to be the view,(view doennt have anylogic) and the controller is the delegete (does the action,cuz it has logic)
    // after we set up delegation , for the txt this method is being called everytimes changes are made on the textfield
    //protocal has to be added first, then this method is inherieted from the protocal.
    //this method is when the change occurs.
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //textField.text shows the text before it changes
        // string is the value that has been enetered
        let existingDecimal = textField.text?.range(of: ".")
        let replacementDecimal = string.range(of: ".")
        if existingDecimal != nil && replacementDecimal != nil{
            return false
        }else{
            return true
        }
        
    }
}

