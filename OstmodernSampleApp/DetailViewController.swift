//
//  DetailViewController.swift
//  OstmodernSampleApp
//
//  Created by Felix Fischer on 23.03.18.
//  Copyright © 2018 Felix Fischer. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var episodeImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    
    let session: URLSessionProtocol = URLSession.shared
    
    var episode: Episode? 
    
    override func viewDidLoad() {
        if let episode = episode {
            titleLabel.text = episode.title
            synopsisLabel.text = episode.synopsis
            loadImage()
        }
    }
    
    private func loadImage() {
        if let episode = episode,
            let path = Bundle.main.path(forResource: episode.image, ofType: episode.imageType) {
            let url = URL(fileURLWithPath: path)
            session.dataTask(with: url, completionHandler: { (data, reponse, error) in
                if let data = data {
                    DispatchQueue.main.async {
                        self.episodeImageView.image = UIImage(data: data)
                    }
                }
            }).resume()
        }
    }
}
