//
//  MenuViewController.swift
//  Tic Tac Toe
//
//  Created by nikita on 20.12.2023.
//

import UIKit

class MenuViewController: UIViewController {

    @IBOutlet weak var aboutButton: UIButton!
    @IBOutlet weak var optionsButton: UIButton!
    @IBOutlet weak var newGame: UIButton!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newGame.setBackgroundImage(UIImage(named: "Menu-Highlighted"), for: .highlighted)
        newGame.imageView?.contentMode = .scaleAspectFill
        optionsButton.setBackgroundImage(UIImage(named: "Menu-Highlighted"), for: .highlighted)
        aboutButton.setBackgroundImage(UIImage(named: "Menu-Highlighted"), for: .highlighted)
       // if UserDefaults.standard.integer(forKey: "DifLevel") == nil{
       //     UserDefaults.standard.setValue("0", forKey: "DifLevel")
       // }
        // Do any additional setup after loading the view.
    }
    

    @IBAction func pressabout(_ sender: Any) {
        print(UserDefaults.standard.string(forKey: "DifLevel")!)
    }
}
