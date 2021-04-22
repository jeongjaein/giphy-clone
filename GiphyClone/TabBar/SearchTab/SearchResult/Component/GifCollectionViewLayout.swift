//
//  GifCollectionViewLayout.swift
//  GiphyClone
//
//  Created by 정재인 on 2021/04/21.
//

import UIKit

protocol GifCollectionViewDelegate: class {
    func collectionView(_ collectionView:UICollectionView) -> [CGSize]
}

class GifCollectionViewLayout: UICollectionViewLayout {
    weak var delegate: GifCollectionViewDelegate!
    
    fileprivate var numberOfColumns = 2
    fileprivate var cellPadding: CGFloat = 3
    fileprivate var cache = [UICollectionViewLayoutAttributes]()
    fileprivate var contentHeight: CGFloat = 0
    fileprivate var contentWidth: CGFloat {
        guard let collectionView = collectionView else {
            return 0
        }
        let insets = collectionView.contentInset
        return collectionView.bounds.width - (insets.left + insets.right)
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func prepare() {
        contentHeight = 0
        guard let collectionView = collectionView else { return }
        
        let columnWidth = contentWidth / CGFloat(numberOfColumns)
        var xOffset = [CGFloat]()
        for column in 0 ..< numberOfColumns {
            xOffset.append(CGFloat(column) * columnWidth)
        }
        var column = 0
        var yOffset = [CGFloat](repeating: 0, count: numberOfColumns)
        let sizeList = self.delegate.collectionView(collectionView)
        
        guard sizeList.count != 0 else { return }
        for item in 0 ..< collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)
            let height = self.cellPadding * 2 + sizeList[item].height
            let scaledHeight = (columnWidth / sizeList[item].width) * height
            
            let frame = CGRect(x: xOffset[column], y: yOffset[column], width: columnWidth, height: scaledHeight)
                let insetFrame = frame.insetBy(dx: self.cellPadding, dy: self.cellPadding)
                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                attributes.frame = insetFrame
                self.cache.append(attributes)
                self.contentHeight = max(self.contentHeight, frame.maxY)
                yOffset[column] = yOffset[column] + scaledHeight
                column = column < (self.numberOfColumns - 1) ? (column + 1) : 0
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        var visibleLayoutAttributes = [UICollectionViewLayoutAttributes]()
        
        // Loop through the cache and look for items in the rect
        for attributes in cache {
            if attributes.frame.intersects(rect) {
                visibleLayoutAttributes.append(attributes)
            }
        }
        return visibleLayoutAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.item]
    }
}
