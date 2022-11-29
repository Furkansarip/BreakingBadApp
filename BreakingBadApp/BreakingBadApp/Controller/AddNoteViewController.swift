//
//  AddNoteViewController.swift
//  BreakingBadApp
//
//  Created by Furkan Sarı on 28.11.2022.
//

import UIKit


class AddNoteViewController: UIViewController {

    @IBOutlet weak var noteTextField: UITextField!
    @IBOutlet weak var episodeTextField: UITextField!
    @IBOutlet weak var seasonTextField: UITextField!
    @IBOutlet weak var addNoteButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        addNoteButton.tintColor = .systemIndigo
    }
    

    @IBAction func addNote(_ sender: Any) {
        CoreDataManager.shared.saveNote(seasonName: seasonTextField.text!, episodeName: episodeTextField.text!, noteText:noteTextField.text!)
    }
    

}
