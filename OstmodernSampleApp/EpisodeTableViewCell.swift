//
//  EpisodeTableViewCell.swift
//  Ostmodern Sample App
//
//  Created by Felix Fischer on 22.03.18.
//  Copyright © 2018 Felix Fischer. All rights reserved.
//

import UIKit

class EpisodeTableViewCell: UITableViewCell {

    
    @IBOutlet weak var epsiodeImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    @IBOutlet weak var favouriteButton: FavouriteButton!
    
    let session: URLSessionProtocol = URLSession.shared
    
    var episode: Episode? {
        didSet {
            titleLabel.text = episode?.title
            synopsisLabel.text = episode?.synopsis
            favouriteButton.isSelected = episode?.favourite ?? false
            loadImage()
        }
    }
    @IBAction func favouriteButtonTouched(_ sender: FavouriteButton) {
        if let episode = episode {
            episode.favourite = !episode.favourite
            sender.isSelected = episode.favourite
        }
        guard let container = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer else {
            return
        }
        do {
            try container.viewContext.save()
        } catch {
            print("Error while saving favourite")
        }
    }
    
    private func loadImage() {
        if let episode = episode,
            let path = Bundle.main.path(forResource: episode.image, ofType: episode.imageType) {
            let url = URL(fileURLWithPath: path)
            session.dataTask(with: url, completionHandler: { (data, reponse, error) in
                if let data = data {
                    DispatchQueue.main.async {
                        self.epsiodeImageView.image = UIImage(data: data)
                    }
                }
            }).resume()
        }
    }
}
