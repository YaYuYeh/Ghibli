//
//  HomeViewController + Extension.swift
//  Ghibli
//
//  Created by Ya Yu Yeh on 2022/10/30.
//

import UIKit
extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(StickerCollectionViewCell.self)", for: indexPath) as! StickerCollectionViewCell
        
        let stickerImg = UIImage(named: "\(movies[indexPath.item])_sticker")
        cell.stickerButton.configuration?.background.image = stickerImg
        cell.stickerButton.tag = indexPath.item
        

        return cell
    }
    
    
}

