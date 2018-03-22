//
//  SkylarkService.swift
//  OstmodernSampleApp
//
//  Created by Felix Fischer on 22.03.18.
//  Copyright © 2018 Felix Fischer. All rights reserved.
//

import UIKit
import CoreData

enum SkylarkServiceError: Error {
    case noPersistentContainer
    case noContextKey
    case noDummyContentPath
}

class SkylarkService: SkylarkServiceProtocol {
    let session: URLSessionProtocol
    
    required init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    func loadHomeSet(completion: @escaping (Result<[Episode]>) -> ()) {
        guard let container = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer else {
            completion(Result.error(SkylarkServiceError.noPersistentContainer))
            return
        }
        
        guard let path = Bundle.main.path(forResource: "sampleData", ofType: "json") else {
            completion(Result.error(SkylarkServiceError.noDummyContentPath))
            return
        }
        
        // TODO: Improve Core Data logic. You have to decide which element is updated. Also the favourite should not be lost while updating.
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            let episodesFromApi = try JSONDecoder().decode([EpisodeObj].self, from: data)
            
            var episodesFromCD = try container.viewContext.fetch(NSFetchRequest<Episode>(entityName: "Episode"))
            
            for episodeAPI in episodesFromApi {
                var insert = true
                for episodeCD in episodesFromCD {
                    if episodeAPI.title == episodeCD.title {
                        insert = false
                    }
                }
                if insert {
                    let entity = NSEntityDescription.entity(forEntityName: "Episode", in: container.viewContext)
                    let newEpisode = NSManagedObject(entity: entity!, insertInto: container.viewContext)
                    newEpisode.setValue(episodeAPI.title, forKey: "title")
                    newEpisode.setValue(episodeAPI.synopsis, forKey: "synopsis")
                    newEpisode.setValue(episodeAPI.image, forKey: "image")
                    newEpisode.setValue(episodeAPI.imageType, forKey: "imageType")
                    if let newEpisode = newEpisode as? Episode {
                        episodesFromCD.append(newEpisode)
                    }
                }
            }
            
            
            try container.viewContext.save()
            completion(Result.success(episodesFromCD))
        } catch let error {
            completion(Result.error(error))
        }
    }
}
