//
//  EpisodesViewController.swift
//  BreakingBadApp
//
//  Created by Furkan Sarı on 22.11.2022.
//

import UIKit

class EpisodesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NetworkManager.shared.getCharacterQuote(author: "Jesse+Pinkman") { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let quote):
                print(quote)
            case.failure(let error):
                print(error)
            }
        }
    }
    

    

}
