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
    
    func getLikeState(gifID: String, userID: String) -> Bool{
        //        removeAllLikeGif()
        let fetchRequest: NSFetchRequest<LikeGif> = LikeGif.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", userID)
        
        do {
            let result = try CoreDataManager.shared.context.fetch(fetchRequest)
            if result.isEmpty {
                let firstLike = LikeGif(context: context)
                firstLike.id = userID
                firstLike.gif = []
                try context.save()
                return false
            } else {
                guard let gifs = result[0].gif else { return false }
                if gifs.contains(gifID) {
                    return true
                }
            }
        } catch { }
        return false
    }
    
    // MARK: 좋아요
    
    func likeGif(gifID: String,
                 userID: String) -> Bool {
        
        let fetchRequest: NSFetchRequest<LikeGif> = LikeGif.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", userID)
        
        do {
            let result = try CoreDataManager.shared.context.fetch(fetchRequest)
            if !result.isEmpty && result[0].gif != nil {
                result[0].gif?.append(gifID)
                try context.save()
                return true
            } else {
                if result[0].gif == nil {
                    let firstLike = LikeGif(context: context)
                    firstLike.id = userID
                    firstLike.gif = [gifID]
                    try context.save()
                    return true
                }
            }
        } catch { }
        return false
    }
    
    // MARK: 좋아요 취소
    
    func unlikeGif(gifID: String,
                   userID: String) -> Bool {
        let fetchRequest: NSFetchRequest<LikeGif> = LikeGif.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", userID)
        
        do {
            let result = try CoreDataManager.shared.context.fetch(fetchRequest)
            guard let removeIndex = result[0].gif?.firstIndex(of: gifID) else { return false }
            result[0].gif?.remove(at: removeIndex)
            
            try context.save()
            return true
        } catch { }
        return false
    }
    
    // MARK: 좋아요 전체 제거
    
    func removeAllLikeGif() {
        guard let userID = UserDefaults.standard.string(forKey: "id") else { return }
        let fetchRequest: NSFetchRequest<LikeGif> = LikeGif.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", userID)
        let objects = try! context.fetch(fetchRequest)
        for obj in objects {
            context.delete(obj)
        }
        do {
            try context.save()
        } catch {}
        //        let delete = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        //        do {
        //            try self.context.execute(delete)
        //        } catch {}
    }
}
