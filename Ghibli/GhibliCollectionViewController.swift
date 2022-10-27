//
//  GhibliCollectionViewController.swift
//  Ghibli
//
//  Created by Ya Yu Yeh on 2022/10/27.
//

import UIKit


class GhibliCollectionViewController: UICollectionViewController {
    
    let test = ["1","2","3","4","5","6","7","8"]

    /*
     龍貓https://www.ghibli.jp/works/totoro/#frame&gid=1&pid=1
     神隱少女https://www.ghibli.jp/works/chihiro/#frame&gid=1&pid=1
     貓的報恩https://www.ghibli.jp/works/baron/#frame&gid=1&pid=1
     平成貍合戰https://www.ghibli.jp/works/tanuki/#frame&gid=1&pid=1
     崖上的波妞https://www.ghibli.jp/works/ponyo/#frame&gid=1&pid=1
     */
    
    var images = [UIImage]()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCellSize()
        getAllImages(imgName: "totoro")
//        print(images)

        
    }
    
    func getImageFromURL(url:URL?, completion: @escaping (UIImage?) -> Void){
        if let url{
            print("URLSession:\(url)")
            URLSession.shared.dataTask(with: url) {
                data, response, error
                in
                if let data,
                   let image = UIImage(data: data){
                    print("completionImage")
                    completion(image)
                }else{
                    print("completionNil")
                    completion(nil)
                }
            }.resume()
        }
    }
    
    func getAllImages(imgName:String){
        //for i in 1...50{
            if let url = URL(string: "https://www.ghibli.jp/works/chihiro/#frame&gid=1&pid=1") {
                print(url)
                getImageFromURL(url: url) { image in
                    if let image{
                        self.images.append(image)
                        print("getAllImages：\(self.images)")
                    }
               // }
                
            }
        }
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
            return test.count
    }
                          
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(GhibliCollectionViewCell.self)", for: indexPath) as! GhibliCollectionViewCell
//        cell.imageView.image = images[indexPath.item]
        cell.imageView.contentMode = .scaleAspectFill
            
            
        return cell
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
