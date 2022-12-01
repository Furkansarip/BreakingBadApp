//
//  AddNoteViewController.swift
//  BreakingBadApp
//
//  Created by Furkan Sarı on 28.11.2022.
//

import UIKit
import SwiftAlertView

class AddNoteViewController: UIViewController {

    @IBOutlet weak var noteTextField: UITextField!
    @IBOutlet weak var episodeTextField: UITextField!
    @IBOutlet weak var seasonTextField: UITextField!
    @IBOutlet weak var addNoteButton: UIButton!
    let seasonPicker = UIPickerView()
    let episodePicker = UIPickerView()
    var episodes = [EpisodesModel]()
    var seasons = ["Season1","Season2","Season3","Season4","Season5"]
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkManager.shared.getAllEpisodes(series: "Breaking+Bad") { result in
            switch result {
            case.success(let episodes):
                self.episodes = episodes
            case.failure(let error):
                print(error)
            }
        }
        seasonPicker.delegate = self
        seasonPicker.dataSource = self
        episodePicker.delegate = self
        episodePicker.dataSource = self
        seasonTextField.inputView = seasonPicker
        episodeTextField.inputView = episodePicker
        createToolbar()
    }
    func createToolbar(){
                let toolbar = UIToolbar()
                toolbar.sizeToFit()
                let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dismissPicker))
                toolbar.setItems([doneButton], animated: false)
                    
                toolbar.isUserInteractionEnabled = true
        seasonTextField.inputAccessoryView = toolbar
        episodeTextField.inputAccessoryView = toolbar
                
            }
            
            @objc func dismissPicker() {
                view.endEditing(true)
            }
    

    @IBAction func addNote(_ sender: Any) {
        if seasonTextField.text != "" && episodeTextField.text != ""  {
            CoreDataManager.shared.saveNote(seasonName: seasonTextField.text!, episodeName: episodeTextField.text!, noteText:noteTextField.text!)
            navigationController?.popViewController(animated: true)
            dismiss(animated: true, completion: nil)
        } else {
            SwiftAlertView.show(title: "Error",message:"Choose a season and episode",buttonTitles: "OK") {
                $0.style = .dark
            }
        }
        
}
    

}
extension AddNoteViewController : UIPickerViewDelegate,UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == seasonPicker {
            return seasons.count
        } else {
            return episodes.count
        }
        
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == seasonPicker {
            return seasons[row]
        } else {
            return episodes[row].title
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == seasonPicker {
            seasonTextField.text = seasons[row]
        } else {
            episodeTextField.text = "Episode: \(row) \(episodes[row].title)"
        }
    }
    
    
}
