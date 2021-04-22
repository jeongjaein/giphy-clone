//
//  RecentSearches+CoreDataProperties.swift
//  
//
//  Created by 정재인 on 2021/04/22.
//
//

import Foundation
import CoreData


extension RecentSearches {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RecentSearches> {
        return NSFetchRequest<RecentSearches>(entityName: "RecentSearches")
    }

    @NSManaged public var id: String?
    @NSManaged public var keyword: String?

}
