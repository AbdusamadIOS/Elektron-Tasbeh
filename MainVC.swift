//
//  MainVC.swift
//  Elektron Tasbeh
//
//  Created by Abdusamad Mamasoliyev on 27/05/23.
//

import UIKit

class MainVC: UIViewController {

    @IBOutlet weak var raqamLbl: UILabel!
    @IBOutlet weak var resetBtn: UIButton!
    @IBOutlet weak var addBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    @IBAction func addPressBtn(_ sender: UIButton) {
        
        let addOne: Int = Int(raqamLbl.text!)! + 1
        
        raqamLbl.text = "\(addOne)"
        
        self.reloadInputViews()
    }
    
    @IBAction func removeBtn(_ sender: UIButton) {
        

        
        if raqamLbl.text == "0" {
            raqamLbl.text = "0"
        }else{
            raqamLbl.text?.removeFirst()
            raqamLbl.text = "0"
        }
        
    }
    

}
