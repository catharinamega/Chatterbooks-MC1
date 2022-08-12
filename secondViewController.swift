//
//  secondViewController.swift
//  Mini Challenge 1 Team 4
//
//  Created by Catharina Adinda Mega Cahyani on 07/04/22.
//

import UIKit

class secondViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var textView: UITextView!

    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var inputStackView: UIStackView!
    
    struct User {
        let username: String
        let judul: String
        let imageName: String
        let tanggal: String
    }
    
    @IBOutlet weak var sendButton: UIButton!
    
    
//    @IBOutlet weak var heightStackViewConstraint: NSLayoutConstraint!
    
//    tambahkan atribut objek untuk nama akun, tanggal, dan waktu
    var data: [User] = [
        User(username: "Kucing1",judul: "I seriously can’t imagine if I were Raib.. Suddenly questioning all my life at once. In a split-sec, I founded out how I only have one cat, how my parents aren’t my real parents.. I don’t even know myself..", imageName: "1", tanggal: "2022-01-09" ),
        User(username: "Bleki", judul: "Definitely Miss Selena. She is the guardianffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff", imageName: "2", tanggal: "2022-01-07"),
        User(username:"Mimi", judul: "Raid is -just like me. So insecure", imageName: "3", tanggal: "2022-08-06"),
        User(username:"Miu", judul: "Tamus has the most unexpectable evil plot", imageName: "4", tanggal:"2022-01-07"),
        User(username:"Pecko", judul: "I can't decide between Raib and Seli. Both of them are great", imageName: "5", tanggal: "2022-01-05")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        textView.delegate = self
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 200, right: 0)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        // Do any additional setup after loading the view.
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if view.frame.origin.y == 0 {
                self.bottomConstraint.constant = keyboardSize.height - 40
                
                self.inputStackView.frame.origin = CGPoint(x: 0, y: keyboardSize.height)
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
//        if view.frame.origin.y != 0 {
            self.bottomConstraint.constant = 20
            self.inputStackView.frame.origin = CGPoint(x: 0, y: 20)
//        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
//        self.view.endEditing(true)
        self.resignFirstResponder()
    }
    

    
    func textViewDidBeginEditing(_ textView: UITextView) {
//        textView.backgroundColor = UIColor.systemGray
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
//        textView.backgroundColor = UIColor.systemGray
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let user = data[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! promptsTableViewCell
        
//        let iv = UIImageView()
//        iv.image = UIImage(named: "flag1")
//        imageDetail.image = UIImage(named: myQuiz1[step].img)
//        descriptionLabel.text = myQuiz1[step].text
//        descriptionTextView.text = myQuiz1[step].text
        
        cell.label.text = user.judul
        cell.usernameLabel.text = user.username
        cell.tanggalLabel.text = user.tanggal
        cell.label.numberOfLines = 0
        /* compression resistance */
        cell.label.setContentCompressionResistancePriority(.required, for: .vertical)
        cell.iconImageView.image = UIImage(named: user.imageName)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        textView.endEditing(true)
    }
    
    
    
    @IBAction func sendButtonClicked(_ sender: Any) {
        guard let komen = textView.text else { return }
        let alert = UIAlertController(title: "Attention", message: "Are you sure you want to post this comment?", preferredStyle: .alert)
        
        let backgroundView = UIView(frame: view.frame)
        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: { [self] _ in
            backgroundView.removeFromSuperview()
        })

        let post = UIAlertAction(title: "Post", style: .default, handler: { [self] _ in
            var tanggal = ""
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
           
            tanggal =  formatter.string(from: Date())
            
            let currentInput = User(username: "Abu", judul: komen, imageName: "1", tanggal: tanggal)
            self.data.insert(currentInput, at: 0)
            self.tableView.reloadData()
            self.textView.endEditing(true)
            self.textView.text = ""
            backgroundView.removeFromSuperview()
        })
        
        backgroundView.backgroundColor = .gray.withAlphaComponent(0.3)

        view.addSubview(backgroundView)
        alert.addAction(cancel)
        alert.addAction(post)
        present(alert, animated: true)
        
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
