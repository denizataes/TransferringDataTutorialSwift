//
//  SecondViewController.swift
//  homework1
//
//  Created by Deniz Ata Eş on 19.12.2022.
//

import Foundation
import UIKit



class SecondViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    //MARK: Picker View Store
    var source = [String]()
    let currentSource: Source = .delegate
    
    //MARK: Defining Properties
    var delegate: DataDelegate!
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var thirdTextField: UITextField!
    @IBOutlet weak var secondTextField: UITextField!
    @IBOutlet weak var firstTextField: UITextField!
    @IBOutlet weak var lblTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //filling the picker view store
        Source.allCases.forEach { item in
            source.append(item.rawValue)
        }
        picker.dataSource = self
        picker.delegate = self
        lblTitle.text = currentSource.rawValue
        backButton.layer.cornerRadius = 10
    
    }
    
    
    @IBAction func buttonClicked(_ sender: UIButton) {
        
        let selectedValue = source[picker.selectedRow(inComponent: 0)]
        
        switch selectedValue{
        //Using Delegate Method
        case Source.delegate.rawValue :
            delegate.dataDidUpdate(data1: firstTextField.text ?? "", data2: secondTextField.text ?? "", data3: thirdTextField.text ?? "")
            dismiss(animated: true, completion: nil)
        //Using Closure Method
        case Source.closure.rawValue:
            if let controller = presentingViewController as? ViewController{
                dismiss(animated: true, completion: {
                    controller.dataEntered(
                        data: self.getData()
                    )}
                )
            }
        //Using NotificationCenter method
        case Source.notificationCenter.rawValue:
            let data = [0: firstTextField.text ?? "", 1: secondTextField.text ?? "", 2: thirdTextField.text ?? ""]
            NotificationCenter.default.post(name: Notification.Name(Constants.key), object:
                                                Constants.key,userInfo: data)
            dismiss(animated: true, completion: nil)
        //Using Segue Method
        case Source.segue.rawValue:
            performSegue(withIdentifier: "goToFirst", sender: self)
        //In Default Uses Segue Method
        default:
            performSegue(withIdentifier: "goToFirst", sender: self)
        }
    }
    //if working with segue this method will trigger
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToFirst"
        {
            let firstVC = segue.destination as! ViewController
            firstVC.first = firstTextField.text ?? ""
            firstVC.second = secondTextField.text ?? ""
            firstVC.third = thirdTextField.text ?? ""
        }
    }
    
}
extension SecondViewController{
    //MARK: PickerView Delegates
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return source.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return source[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        lblTitle.text = source[row]
    }
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return NSAttributedString(string: source[row], attributes: [NSAttributedString.Key.foregroundColor : UIColor.systemBlue])
    }
    
    //MARK: For Closure
    func getData() -> [String]{
        var returnStr = [String]()
        returnStr.append(firstTextField.text ?? "")
        returnStr.append(secondTextField.text ?? "")
        returnStr.append(thirdTextField.text ?? "")
        return returnStr
    }
}


