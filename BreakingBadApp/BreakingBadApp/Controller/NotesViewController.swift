//
//  NoteViewController.swift
//  BreakingBadApp
//
//  Created by Furkan Sarı on 28.11.2022.
//

import UIKit

class NotesViewController: UIViewController {

    @IBOutlet weak var noteTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureButton()
        noteTableView.delegate = self
        noteTableView.dataSource = self
        
    }
    
    func configureButton(){
        let floatingButton = UIButton()
                floatingButton.setTitle("Add", for: .normal)
        floatingButton.backgroundColor = .systemPink
                floatingButton.layer.cornerRadius = 25
                
                view.addSubview(floatingButton)
                floatingButton.translatesAutoresizingMaskIntoConstraints = false

                floatingButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
                floatingButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
                
                floatingButton.bottomAnchor.constraint(equalTo: self.view.layoutMarginsGuide.bottomAnchor, constant: -10).isActive = true

                floatingButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
               //floatingButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
                floatingButton.addTarget(self, action: #selector(addNote), for: .touchUpInside)
    }
    @objc func addNote(){
        performSegue(withIdentifier: "addNote", sender: nil)
    }


}

extension NotesViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "hello"
        return cell
    }
    
  
    
    
}