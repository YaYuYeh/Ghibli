//
//  ImageViewController.swift
//  Ghibli
//
//  Created by sam su on 2022/11/8.
//

import UIKit

class ImageViewController: UIViewController {
    var detailImage: UIImage!

    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = detailImage
    }
}
