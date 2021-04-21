//
//  LikeGif+CoreDataProperties.swift
//  
//
//  Created by 정재인 on 2021/04/22.
//
//

import Foundation
import CoreData


extension LikeGif {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LikeGif> {
        return NSFetchRequest<LikeGif>(entityName: "LikeGif")
    }

    @NSManaged public var id: String?
    @NSManaged public var gif: [String]?

}
