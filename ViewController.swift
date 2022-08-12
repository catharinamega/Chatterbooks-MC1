//
//  ViewController.swift
//  Mini Challenge 1 Team 4
//
//  Created by Catharina Adinda Mega Cahyani on 05/04/22.
//

import UIKit

class ViewController: UIViewController {
//    interface builder
//    @IBOutlet var tableView: UITableView!
    var yes_click = false
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var judulLabel: UILabel!
    
    let prompts = ["Which character would you most like to meet and why?",
                   "If you were in that adventure, which character do you want to have a guide?",
                   "Which part of the story frustrate you the most?",
                   "If you were in that adventure, which character do you want to have as guide?",
                   "What did you like best about this book?",
                   "Which place in the book would you most like to visit?",
                   "What does this story make you think or wonder about?"
                   
                   ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        judulLabel.numberOfLines = 0
        judulLabel.text = "You haven't scan barcode"
    }
    
    
    @IBAction func scanButtonClicked(_ sender: Any) {
        
//        DICOMMENT KALAU JADINYA TETAP PAKAI MODAL
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "scanBarcode") as! scanBarcodeViewController
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    

}



extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("you tapped me")
    }
}

extension ViewController:UITableViewDataSource{
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 6
//    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
//        return prompts.count
        return yes_click ? prompts.count : 0
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for:indexPath)
        
        cell.textLabel?.text = prompts[indexPath.row]
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = .byWordWrapping
        return cell
    }
}

extension ViewController:scanBarcodeProtocol{
    func back_to_prompt() {
        yes_click = true
        judulLabel.text = "Bumi"
        tableView.reloadData()
        
    }
}


