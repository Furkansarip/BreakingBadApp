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
    var status = ""
    var nickname = ""
    var name = ""
    var birthday = ""
    var imgURL = ""
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharacterCell", for: indexPath) as! CharacterViewCell
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
        name = characterArray[indexPath.item].name
        nickname = characterArray[indexPath.item].nickname
        birthday = characterArray[indexPath.item].birthday
        status = characterArray[indexPath.item].status
        imgURL = characterArray[indexPath.item].img
        performSegue(withIdentifier: "characterDetail", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! CharacterDetailViewController
        destination.name = name
        destination.nickname = nickname
        destination.birthday = birthday
        destination.status = status
        destination.imgURL = imgURL
        
    }
    
    
}

