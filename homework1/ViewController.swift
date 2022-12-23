//
//  ViewController.swift
//  homework1
//
//  Created by Deniz Ata Eş on 19.12.2022.
//

import UIKit

protocol DataDelegate {
    func dataDidUpdate(data1: String,data2: String,data3: String)
}

class ViewController: UIViewController{
    //MARK: Defining properties
    
    @IBOutlet weak var thirdLbl: UILabel!
    @IBOutlet weak var secondLbl: UILabel!
    @IBOutlet weak var firstLbl: UILabel!
    @IBOutlet weak var btnNext: UIButton!
    
    var first: String = "Ad"
    var second: String = "Soyad"
    var third: String = "Yaş"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstLbl.text = first
        secondLbl.text = second
        thirdLbl.text = third
        btnNext.layer.cornerRadius = 10
        
        
        //MARK: NotificationCenter Listener
        NotificationCenter.default.addObserver(self, selector: #selector(listenAndPerform), name: Notification.Name(Constants.key), object: nil)
        
    }
    
    //MARK: Switch Views using segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToSecond"
        {
            let secondVC = segue.destination as! SecondViewController
            secondVC.delegate = self
        }
    }

    @IBAction func buttonClicked(_ sender: Any) {
        performSegue(withIdentifier: "goToSecond", sender: self)
    }
    
}

extension ViewController: DataDelegate{
    
    //MARK: For Delegate(Protocol)
    func dataDidUpdate(data1: String, data2: String, data3: String) {
        firstLbl.text = data1
        secondLbl.text  = data2
        thirdLbl.text  = data3
    }
    
    //MARK: For Closure
    func dataEntered(data: [String])
    {
        firstLbl.text = data[0]
        secondLbl.text = data[1]
        thirdLbl.text = data[2]
    }
    
    //MARK: For Notification Center
    @objc func listenAndPerform(data: Notification)
    {
        firstLbl.text = data.userInfo![0] as? String
        secondLbl.text = data.userInfo![1] as? String
        thirdLbl.text = data.userInfo![2] as? String

    }
}
