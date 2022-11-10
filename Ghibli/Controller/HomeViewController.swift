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
    //建立資料陣列
    let ghibliArray = [
        Ghibli(title: "となりのトトロ", released: "1988", picture: "totoro", trailer: "92a7Hj0ijLs"),
        Ghibli(title: "魔女の宅急便", released: "1989", picture: "majo", trailer: "4bG17OYs-GA&t=31s"),
        Ghibli(title: "平成狸合戦ぽんぽこ", released: "1994", picture: "tanuki", trailer: "I4V_8cD6c8I"),
        Ghibli(title: "耳をすませば", released: "1995", picture: "mimi", trailer: "0pVkiod6V0U"),
        Ghibli(title: "もののけ姫", released: "1997", picture: "mononoke", trailer: "uuZUoLysYfQ"),
        Ghibli(title: "千と千尋の神隠し", released: "2001", picture: "chihiro", trailer: "etiQRSOkOIg"),
        Ghibli(title: "猫の恩返し", released: "2002", picture: "baron", trailer: "0sEycbCo4SE"),
        Ghibli(title: "ハウルの動く城", released: "2004", picture: "howl", trailer: "_hsAkoI07Jg"),
        Ghibli(title: "崖の上のポニョ", released: "2008", picture: "ponyo", trailer: "6WlVvl8hK5M")
    ]
    
    //MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        //捲動時不顯示下方卷軸
        posterCollectionView.showsHorizontalScrollIndicator = false
        putStickersBackgorund()
        navigationItem.title = "スタジオジブリ"
    }
    
    func putStickersBackgorund(){
        for i in ghibliArray.indices {
            let stickerImage = UIImage(named: "\(ghibliArray[i].picture)_sticker")
            //設定按鈕背景圖片
            stickerButtons[i].configuration?.background.image = stickerImage
            //設定點選按鈕時變色
            stickerButtons[i].configurationUpdateHandler = { button in
                button.alpha = button.isHighlighted ? 0.5 : 1
            }
            stickerButtons[i].tag = i
            stickerLabels[i].text = ghibliArray[i].title
        }
    }
    
    
    @IBAction func turnToPhotoWall(_ sender: UIButton) {
        guard let photoWallCVC = storyboard?.instantiateViewController(withIdentifier: "\(PhotoWallCollectionViewController.self)") as? PhotoWallCollectionViewController else {return}
        photoWallCVC.ghibli = ghibliArray[sender.tag]
        print(sender.tag)
        navigationController?.pushViewController(photoWallCVC, animated: true)
    }
    
    @IBSegueAction func sendTrailer(_ coder: NSCoder) -> TrailerViewController? {
        let trailerVC = TrailerViewController(coder: coder)
        if let posterIndex = posterCollectionView.indexPathsForSelectedItems?.first{
            trailerVC?.ghibli = ghibliArray[posterIndex.item]
        }
        return trailerVC
    }
}


extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    //MARK: - UICollectionViewDataSource
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        ghibliArray.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(PosterCollectionViewCell.self)", for: indexPath) as! PosterCollectionViewCell
        let posterImage = UIImage(named: "\(ghibliArray[indexPath.item].picture)_poster")
        print(ghibliArray[indexPath.item].picture)

        cell.posterImageView.image = posterImage
        cell.posterImageView.contentMode = .scaleAspectFill
        cell.posterImageView.layer.cornerRadius = 10
        cell.posterImageView.clipsToBounds = true
        return cell
    }
    
    //MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showTrailer", sender: nil)
    }
}
