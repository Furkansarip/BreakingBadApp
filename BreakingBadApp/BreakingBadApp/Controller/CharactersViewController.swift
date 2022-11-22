//
//  ViewController.swift
//  BreakingBadApp
//
//  Created by Furkan Sarı on 22.11.2022.
//

import UIKit
import Kingfisher

final class CharactersViewController: UIViewController {
    private var characterArray = [CharacterModel]()
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
       getAllCharacters()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        let lay = UICollectionViewFlowLayout()
        lay.itemSize = CGSize(width: 120, height: 120)
        collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CharacterCell")
        
    }
    func getAllCharacters(){
        NetworkManager.shared.getAllCharacters(path: "characters") { [weak self] result in
             guard let self = self else { return }
             switch result {
             case .success(let characters):
                 self.characterArray = characters
                 DispatchQueue.main.async {
                     self.collectionView.reloadData()
                 }
             case .failure(let error):
                 print(error)
             }
         }
    }

}



extension CharactersViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characterArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharacterCell", for: indexPath) as! CollectionViewCell
        cell.characterNameLabel.text = "Name : \(characterArray[indexPath.item].name)"
        cell.birthdayLabel.text = "Birthday : \(characterArray[indexPath.item].birthday)"
        cell.nicknameLabel.text = "Nickname : \(characterArray[indexPath.item].nickname)"
        let url = URL(string: characterArray[indexPath.item].img)
        cell.imageView.kf.setImage(with: url)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 341, height: 188)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "characterDetail", sender: nil)
    }
    
    
}

