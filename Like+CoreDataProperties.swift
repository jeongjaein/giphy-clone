//
//  Like+CoreDataProperties.swift
//  
//
//  Created by 정재인 on 2021/04/22.
//
//

import Foundation
import CoreData


extension Like {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Like> {
        return NSFetchRequest<Like>(entityName: "Like")
    }

    @NSManaged public var id: Int64
    @NSManaged public var gifID: NSObject?

}
