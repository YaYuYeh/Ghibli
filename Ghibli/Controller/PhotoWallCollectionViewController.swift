//
//  PhotoWallCollectionViewController.swift
//  Ghibli
//
//  Created by Ya Yu Yeh on 2022/10/30.
//

import UIKit

class PhotoWallCollectionViewController: UICollectionViewController {
    var images = [UIImage]()
    var ghibli:Ghibli!
    var testI = 0   // 測試用
    let loadingIndicator = UIActivityIndicatorView()
    
    //MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        getAllImages(imgName: ghibli.picture)
        addLoadingView()
        configureCellSize()
        navigationItem.title = ghibli.title
    }
    
    //產生載入器
    func addLoadingView(){
        //設定與主view的尺寸&位置相同(置中填滿)
        loadingIndicator.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        //設定動畫
        loadingIndicator.startAnimating()
        //設定樣式:Medium、Large、Large White、White、Gray
        loadingIndicator.style = .large
        //設定顏色
        loadingIndicator.color = .systemPink
        //設定背景顏色(也可直接設定view的背景顏色)
        loadingIndicator.backgroundColor = .white
        loadingIndicator.hidesWhenStopped = true
        //在主view加入載入器
        view.addSubview(loadingIndicator)
    }
    
    
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
                getImageFromURL(url: url) { image in
                    if let image{
                        self.images.append(image)
                    } else {
                        print("no image yet")
                    }
                }
            }
        }
//        跑到這裡還沒拿到 image
    }
    
    //設定cell大小&位置
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
              
    
    // MARK: - UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
                          
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(PhotoWallCollectionViewCell.self)", for: indexPath) as! PhotoWallCollectionViewCell
        cell.imageView.contentMode = .scaleAspectFill
        
        DispatchQueue.main.async {
            if self.images.count == 50{
                cell.imageView.image = self.images[indexPath.item]
                //取得所有照片後，移除載入器
                self.loadingIndicator.stopAnimating()
                self.loadingIndicator.removeFromSuperview()
            }
        }
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetail", sender: nil)
    }
        
        
    @IBSegueAction func showDetail(_ coder: NSCoder, sender: Any?, segueIdentifier: String?) -> ImageViewController? {
        guard let detailVC = ImageViewController(coder: coder) else {return nil}
        if let item = collectionView.indexPathsForSelectedItems?.first?.item{
                detailVC.detailImage = self.images[item]
        }
        return detailVC
    }
}
