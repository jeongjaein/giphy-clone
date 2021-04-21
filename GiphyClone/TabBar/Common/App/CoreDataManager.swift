//
//  CoreDataManager.swift
//  GiphyClone
//
//  Created by 정재인 on 2021/04/22.
//

import UIKit
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
    lazy var context = appDelegate.persistentContainer.viewContext
    
    //MARK: 좋아요 상태
    
    func getLikeState(gifID: String,
                      userID: String,
                      completion: @escaping (Bool) -> Void) {
        let fetchRequest: NSFetchRequest<LikeGif> = LikeGif.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", userID)
        do {
            let result = try CoreDataManager.shared.context.fetch(fetchRequest)
            result[0].gif?.forEach {
                if gifID == $0 {
                    completion(true)
                }
            }
            completion(false)
        } catch {
            completion(false)
        }
    }
    
    // MARK: 좋아요
    
    func likeGif(gifID: String,
                       userID: String,
                       completion: @escaping (Bool) -> Void) {
        let newLike = LikeGif(context: context)
        newLike.id = userID
        newLike.gif?.append(gifID)
        
        do {
            try context.save()
            completion(true)
        } catch {
            completion(false)
        }
    }
    
    // MARK: 좋아요 취소
    
    func unlikeGif(gifID: String,
                   userID: String,
                   completion: @escaping (Bool) -> Void) {
        let fetchRequest: NSFetchRequest<LikeGif> = LikeGif.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", userID)
        do {
            let result = try CoreDataManager.shared.context.fetch(fetchRequest)
            guard let removeIndex = result[0].gif?.firstIndex(of: gifID) else { return }
            result[0].gif?.remove(at: removeIndex)
            
            try context.save()
            completion(true)
        } catch {
            completion(false)
        }
    }
}
