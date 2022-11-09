//
//  TrailerViewController.swift
//  Ghibli
//
//  Created by sam su on 2022/11/9.
//

import UIKit
import WebKit

class TrailerViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    var ghibli:Ghibli!
    let baseURL = "https://www.youtube.com/watch?v="

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = ghibli.title
        playTrailer()
    }
    
    func playTrailer(){
        if let url = URL(string: baseURL + ghibli.trailer){
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
}
