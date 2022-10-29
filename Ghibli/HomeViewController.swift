//
//  HomeViewController.swift
//  Ghibli
//
//  Created by Ya Yu Yeh on 2022/10/27.
//

import UIKit

class HomeViewController: UIViewController {

//    let ghiblis = ["":"", "":""]
    
    @IBOutlet weak var testImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getImage { image in
            DispatchQueue.main.async {
                self.testImage.image = image
            }
            
        }
        
    }
    
    func getImage(completion: @escaping (UIImage?) -> Void){
        if let url = URL(string: "https://www.ghibli.jp/gallery/totoro001.jpg"){
            URLSession.shared.dataTask(with: url) {
                data, response, error
                in
                if let data,
                   let image = UIImage(data: data){
                    completion(image)
                }else{
                    completion(nil)
                }
            }.resume()
            
        }
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
