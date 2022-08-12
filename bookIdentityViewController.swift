//
//  bookIdentityViewController.swift
//  Mini Challenge 1 Team 4
//
//  Created by Catharina Adinda Mega Cahyani on 10/04/22.
//

import UIKit
protocol bookIdentityProtocol{
    func correct_book()

}

class bookIdentityViewController: UIViewController {
    var delegate:bookIdentityProtocol?
    override func viewDidLoad() {
        
        super.viewDidLoad()
//        view.backgroundColor = .red
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func yesButtonClicked(_ sender: Any) {
        
        delegate?.correct_book()
        dismiss(animated: true)
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
