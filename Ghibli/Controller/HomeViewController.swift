//
//  HomeViewController.swift
//  Ghibli
//
//  Created by Ya Yu Yeh on 2022/10/27.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var testBtn: UIButton!
    //    let ghiblis = ["":"", "":""]
    /*
     1988龍貓https://www.ghibli.jp/gallery/totoro001.jpg
     1989魔女宅急便https://www.ghibli.jp/gallery/majo001.jpg
     1994平成貍合戰https://www.ghibli.jp/gallery/tanuki001.jpg
     1995心之谷https://www.ghibli.jp/gallery/mimi001.jpg
     1997魔法公主https://www.ghibli.jp/gallery/mononoke001.jpg
     2001神隱少女https://www.ghibli.jp/gallery/chihiro001.jpg
     2002貓的報恩https://www.ghibli.jp/gallery/baron001.jpg
     2004霍爾的移動城堡https://www.ghibli.jp/gallery/howl001.jpg
     2008崖上的波妞https://www.ghibli.jp/gallery/ponyo001.jpg
     */
    
    var movies = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getAllMovies()
        
    }
  
    
    func getAllMovies(){
        for movie in Ghibli.allCases {
            let aMovie = movie.rawValue
            movies.append(aMovie)
        }
        print(movies)
    }
    
    
    
 
    
    
  
    @IBAction func turnToPhotoWall(_ sender: Any) {
        performSegue(withIdentifier: "\(PhotoWallCollectionViewController.self)", sender: nil)
        
        
    }
    
    
    
    @IBSegueAction func passStickerMovie(_ coder: NSCoder) -> PhotoWallCollectionViewController? {
        let item = view.tag
        print(item)
        let photoWallCVC = PhotoWallCollectionViewController(coder: coder)
        
        photoWallCVC?.movie = movies[item]
        return photoWallCVC
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
