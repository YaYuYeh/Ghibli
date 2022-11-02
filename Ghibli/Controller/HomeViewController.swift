//
//  HomeViewController.swift
//  Ghibli
//
//  Created by Ya Yu Yeh on 2022/10/27.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet var stickerButtons: [UIButton]!
    
    @IBOutlet weak var testBtn: UIButton!
    
    //    let ghiblis = ["":"", "":""]    
    var movies = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    
        
        
        getAllMovies()
        putStickers()
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
        }
    }
    
    
    @IBAction func turnToPhotoWall(_ sender: UIButton) {
//        performSegue(withIdentifier: "\(PhotoWallCollectionViewController.self)", sender: nil)
        guard let photoWallCVC = storyboard?.instantiateViewController(withIdentifier: "\(PhotoWallCollectionViewController.self)") as? PhotoWallCollectionViewController else {return}
        photoWallCVC.movie = movies[sender.tag]
        print(sender.tag)
        navigationController?.pushViewController(photoWallCVC, animated: true)
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

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movies.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(PosterCollectionViewCell.self)", for: indexPath) as! PosterCollectionViewCell
        let posterImage = UIImage(named: "\(movies[indexPath.item])_poster")
        cell.posterImageView.image = posterImage
        cell.posterImageView.contentMode = .scaleAspectFill
        cell.posterImageView.layer.cornerRadius = 20
        cell.posterImageView.clipsToBounds = true
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.size.width / 2
        let cellSize = CGSize(width: width, height: width * 1.5)
        print("cell:\(cellSize)")
        return cellSize
    }
}
