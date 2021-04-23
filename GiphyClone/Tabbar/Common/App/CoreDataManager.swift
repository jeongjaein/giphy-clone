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
    
    // MARK: 최근 검색어 조회
    
    func getRecentSearches(userID: String) -> [String] {
        let fetchRequest: NSFetchRequest<RecentSearches> = RecentSearches.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", userID)
        
        do {
            let result = try CoreDataManager.shared.context.fetch(fetchRequest)
            if result.isEmpty {
                let initSearches = RecentSearches(context: context)
                initSearches.id = userID
                initSearches.keyword = []
                try context.save()
                return []
            } else {
                guard let searchs = result[0].keyword else { return [] }
                return searchs
            }
        } catch { }
        return []
    }
    
    // MARK: 검색어 추가
    
    func putRecentSearches(keyword: String, userID: String) -> [String] {
        let fetchRequest: NSFetchRequest<RecentSearches> = RecentSearches.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", userID)
        
        do {
            let result = try CoreDataManager.shared.context.fetch(fetchRequest)
            if result.isEmpty {
                let initSearches = RecentSearches(context: context)
                initSearches.id = userID
                initSearches.keyword = [keyword]
                try context.save()
                return [keyword]
            } else {
                guard var searches = result[0].keyword else { return [] }
                if searches.contains(keyword) {
                    if let removeIndex = searches.firstIndex(of: keyword) {
                        searches.remove(at: removeIndex)
                        searches.insert(keyword, at: 0)
                    }
                } else {
                    result[0].keyword?.insert(keyword, at: 0)
                    if result[0].keyword?.count ?? 0 > 5 {
                        result[0].keyword?.removeLast()
                    }
                }
                try context.save()
                return searches
            }
        } catch { }
        return []
    }
    
    // MARK: 검색어 삭제
    
    func removeRecentSearches(keyword: String, userID: String) -> [String] {
        let fetchRequest: NSFetchRequest<RecentSearches> = RecentSearches.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", userID)
        
        do {
            let result = try CoreDataManager.shared.context.fetch(fetchRequest)
            if result.isEmpty {
                return []
            } else {
                guard let removeIndex = result[0].keyword?.firstIndex(of: keyword) else { return [] }
                result[0].keyword?.remove(at: removeIndex)
                try context.save()
            }
        } catch { }
        return []
    }
    
}




// MARK: LIKE

extension CoreDataManager {
    
    // MARK: 좋아요 상태
    
    func getLikeState(gifID: String, userID: String) -> Bool {
        let fetchRequest: NSFetchRequest<LikeGif> = LikeGif.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", userID)
        
        do {
            let result = try CoreDataManager.shared.context.fetch(fetchRequest)
            if result.isEmpty {
                let initLike = LikeGif(context: context)
                initLike.id = userID
                initLike.gif = []
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
    }
}
