//
//  PhotoWallCollectionViewController.swift
//  Ghibli
//
//  Created by Ya Yu Yeh on 2022/10/30.
//

import UIKit

class PhotoWallCollectionViewController: UICollectionViewController {
    var images = [UIImage]()
    var movie:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCellSize()
        getAllImages(imgName: movie)
    }
    
    var testI = 0   // 測試用
    //URLSession抓圖
    func getImageFromURL(url:URL?, completion: @escaping (UIImage?) -> Void) {
        if let url{
            URLSession.shared.dataTask(with: url) {
                data, response, error
                in
                if let data,
                   let image = UIImage(data: data) {
                    
                    DispatchQueue.main.async {
                        //拿到一個image就reloadㄧ次
                        self.collectionView.reloadData()
                    }
                    completion(image)
                }else{
                    print("URLSession didn't get image")
                    completion(nil)
                }
            }.resume()
        }
    }
    
    
    //透過URL取得UIImage，並加進陣列中
    func getAllImages(imgName:String){
        
        for i in 1...50 {
            testI = i
//            print("getting image \(testI)") // 1-50 會先跑完
            
            let imgNum = String(format: "%03d.jpg", i)
            if let url = URL(string: "https://www.ghibli.jp/gallery/\(imgName)\(imgNum)") {
//                print(url)
                getImageFromURL(url: url) { image in
                    if let image{
                        self.images.append(image)
//                        print("append image \(self.images.count)")
                    } else {
                        print("no image yet")
                    }
                }
            }
        }
        //跑到這裡還沒拿到 image
    }
    
    
    func configureCellSize(){
        //cell間距
        let itemSpace: Double = 4
        //一排幾個cell -->減1可以得到有幾個間距
        let columCount: Double = 3
        //控制怎麼排畫面
        let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout
        //cell寬度 = (螢幕寬度 - cell間距 * 數量) / 一排幾個cell
        let width = floor((collectionView.bounds.width - itemSpace * (columCount-1)) / columCount)
        flowLayout?.itemSize = CGSize(width: width, height: width)
        //estimatedItemSize設為0通知cell大小要由我們指定
        flowLayout?.estimatedItemSize = .zero
        flowLayout?.minimumLineSpacing = itemSpace
        flowLayout?.minimumInteritemSpacing = itemSpace
        
    }
                          
    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
                          
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(PhotoWallCollectionViewCell.self)", for: indexPath) as! PhotoWallCollectionViewCell
        cell.imageView.contentMode = .scaleAspectFill
        
        DispatchQueue.main.async {
            if self.images.isEmpty == false{
//                print("get images array")
                cell.imageView.image = self.images[indexPath.item]
            }else{
//                print("images array is empty")
            }
//
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetail", sender: nil)
    }
        
        
 
    @IBSegueAction func showDetail(_ coder: NSCoder, sender: Any?, segueIdentifier: String?) -> DetailViewController? {
        guard let detailVC = DetailViewController(coder: coder) else {return nil}
        if let item = collectionView.indexPathsForSelectedItems?.first?.item{
//            DispatchQueue.main.async {
                detailVC.imageView.image = self.images[item]
//            }
            
        }
        
        return detailVC
        
    }
    
        
        
        // MARK: UICollectionViewDelegate
        
        /*
         // Uncomment this method to specify if the specified item should be highlighted during tracking
         override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
         return true
         }
         */
        
        /*
         // Uncomment this method to specify if the specified item should be selected
         override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
         return true
         }
         */
        
        /*
         // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
         override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
         return false
         }
         
         override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
         return false
         }
         
         override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
         
         }
         */
        
        
        
        
        /*
         // MARK: - Navigation
         
         // In a storyboard-based application, you will often want to do a little preparation before navigation
         override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using [segue destinationViewController].
         // Pass the selected object to the new view controller.
         }
         */

}
