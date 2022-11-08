//
//  HomeViewController.swift
//  Ghibli
//
//  Created by Ya Yu Yeh on 2022/10/27.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet var stickerButtons: [UIButton]!
    @IBOutlet var stickerLabels: [UILabel]!
    @IBOutlet weak var posterCollectionView: UICollectionView!
    let stickers = ["となりのトトロ", "魔女の宅急便", "平成狸合戦ぽんぽこ", "耳をすませば", "もののけ姫", "千と千尋の神隠し", "猫の恩返し", "ハウルの動く城", "崖の上のポニョ"]

    
    var movies = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getAllMovies()
        putStickers()
        navigationItem.title = "スタジオジブリ"
        
    }
  
    
    func getAllMovies(){
        for movie in Ghibli.allCases {
            let aMovie = movie.rawValue
            movies.append(aMovie)
        }
        print(movies)
    }
    
    func putStickers(){
        for i in movies.indices {
            let stickerImage = UIImage(named: "\(movies[i])_sticker")
            stickerButtons[i].configuration?.background.image = stickerImage
            stickerButtons[i].tag = i
            stickerLabels[i].text = stickers[i]
        }
    }
    
    
    @IBAction func turnToPhotoWall(_ sender: UIButton) {
        guard let photoWallCVC = storyboard?.instantiateViewController(withIdentifier: "\(PhotoWallCollectionViewController.self)") as? PhotoWallCollectionViewController else {return}
        photoWallCVC.movie = movies[sender.tag]
        print(sender.tag)
        navigationController?.pushViewController(photoWallCVC, animated: true)
    }
}


extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movies.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(PosterCollectionViewCell.self)", for: indexPath) as! PosterCollectionViewCell
        let posterImage = UIImage(named: "\(movies[indexPath.item])_poster")
        cell.posterImageView.image = posterImage
        cell.posterImageView.contentMode = .scaleAspectFill
        cell.posterImageView.layer.cornerRadius = 10
        cell.posterImageView.clipsToBounds = true
        return cell
    }
}
