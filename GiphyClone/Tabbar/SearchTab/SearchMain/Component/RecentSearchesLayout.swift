//
//  RecentSearchesLayout.swift
//  GiphyClone
//
//  Created by 정재인 on 2021/04/29.
//

import UIKit

class RecentSearchesLayout: UICollectionViewCompositionalLayout {
    override init(section: NSCollectionLayoutSection? = nil) {
        
        let size = NSCollectionLayoutSize(
            widthDimension: .estimated(40),
            heightDimension: .estimated(40))
        
        let item = NSCollectionLayoutItem(layoutSize: size)
        
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: size, subitem: item, count: 1)
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 10, leading: 10, bottom: 10, trailing: 10)
        section.interGroupSpacing = 10
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        super.init(section: section)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
