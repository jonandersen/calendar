//
//  NoAnimationLayout.swift
//  leapsecond
//
//  Created by Jon Andersen on 1/15/16.
//  Copyright © 2016 Andersen. All rights reserved.
//

import Foundation


class CalendarLayout: UICollectionViewFlowLayout {
    var isInsertingCellsToTop: Bool = false
    var contentSizeWhenInsertingToTop: CGSize?

    override func prepareLayout() {
        super.prepareLayout()
        if isInsertingCellsToTop == true {
            if let collectionView = collectionView, oldContentSize = contentSizeWhenInsertingToTop {
                let newContentSize = collectionViewContentSize()
                let contentOffsetY = collectionView.contentOffset.y + (newContentSize.height - oldContentSize.height)
                let newOffset = CGPoint(x: collectionView.contentOffset.x, y: contentOffsetY)
                collectionView.contentOffset = newOffset
            }
            contentSizeWhenInsertingToTop = nil
            isInsertingCellsToTop = false
        }
    }

    override func initialLayoutAttributesForAppearingItemAtIndexPath(itemIndexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        return nil
    }

    override func finalLayoutAttributesForDisappearingItemAtIndexPath(itemIndexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        return nil
    }

    override func initialLayoutAttributesForAppearingSupplementaryElementOfKind(elementKind: String,
        atIndexPath elementIndexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        return nil
    }

    override func finalLayoutAttributesForDisappearingSupplementaryElementOfKind(elementKind: String,
        atIndexPath elementIndexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        return nil
    }

    override func initialLayoutAttributesForAppearingDecorationElementOfKind(elementKind: String,
        atIndexPath decorationIndexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        return nil
    }

    override func finalLayoutAttributesForDisappearingDecorationElementOfKind(elementKind: String,
        atIndexPath decorationIndexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        return nil
    }
}
