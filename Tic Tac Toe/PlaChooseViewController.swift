//
//  PlaChooseViewController.swift
//  Tic Tac Toe
//
//  Created by nikita on 23.12.2023.
//

import UIKit

class PlaChooseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func netButton(_ sender: Any) {
        dismiss(animated: true)
    }
    
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let ID = segue.identifier else {return}
        let newVc = segue.destination as! MainViewController
            newVc.IncomeSegueID = ID
    }
    

}
