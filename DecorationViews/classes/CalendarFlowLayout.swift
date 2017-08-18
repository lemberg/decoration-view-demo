//
//  EventsFlowLayout.swift
//  DecorationViews
//
//  Created by Hellen Soloviy on 8/18/17.
//  Copyright © 2017 Lemberg Solutions Limited. All rights reserved.
//

import Foundation
import UIKit

protocol CalendarFlowLayoutDelegate: UICollectionViewDelegateFlowLayout {
  //      func collectionView(_ collectionView: UICollectionView, layout: MosaicPinLayout, originalItemSizeAtIndexPath: IndexPath) -> CGSize
}

class CalendarFlowLayout: UICollectionViewFlowLayout {
  
  var delegate: CalendarFlowLayoutDelegate!
  var numberOfColumns = 2
  
  private let timeLine = "TimeLine"
  private var titleRect : CGRect = CGRect(x: 10, y: 0, width: 200, height: 50)
  
  override init() {
    super.init()
    register(TimeLineGrid.self, forDecorationViewOfKind: self.timeLine)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  /// Array of all attributes for cells
  private var cache = [UICollectionViewLayoutAttributes]()
  
  
  /// Need to save it because of func `collectionViewContentSize`
  private var contentHeight: CGFloat  = 0.0
  
  var flowContentInset: UIEdgeInsets  {
    return UIEdgeInsets(top: minimumLineSpacing, left: minimumInteritemSpacing, bottom: minimumLineSpacing, right: minimumInteritemSpacing)
  }
  
  private var contentGeneralWidth: CGFloat {
    return collectionView!.bounds.width //- (flowContentInset.left + flowContentInset.right)
  }
  
  private var contentWidthWithoutSpacing: CGFloat {
    return contentGeneralWidth - offsetGeneralWidth
  }
  
  private var offsetGeneralWidth: CGFloat {
    return minimumInteritemSpacing * CGFloat(numberOfColumns + 1)
  }
  
  override func prepare() {
    super.prepare()
    
    guard let collectionView = self.collectionView else { return }
    
    cache = [UICollectionViewLayoutAttributes]()
    contentHeight = 0
    
    let columnWidth = contentWidthWithoutSpacing / CGFloat(numberOfColumns)
    
    let numberOfSections: NSInteger = collectionView.numberOfSections
    
    guard numberOfSections > 0 else {
      return
    }
    
    if cache.isEmpty {
      
      let columnWidth = 80
      var xOffset = [CGFloat]()
      for column in 0 ..< numberOfColumns {
        xOffset.append(CGFloat(column * columnWidth))
      }
      for item in 0 ..< collectionView.numberOfItems(inSection: 0) {
        
        let indexPath = IndexPath(row: item, section: 0)
        let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        
        attributes.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        cache.append(attributes)
      }
    }
  }
  
  
  
  override func layoutAttributesForDecorationView( ofKind elementKind: String, at indexPath: IndexPath) ->
    UICollectionViewLayoutAttributes? {
      
      let atts = UICollectionViewLayoutAttributes(
        forDecorationViewOfKind:timeLine, with:indexPath)
      atts.frame = self.titleRect
      atts.zIndex = -1
      return atts
  }
  
  
  override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    var layoutAttributes = [UICollectionViewLayoutAttributes]()
    
    for attributes in cache {
      
      if attributes.frame.intersects(rect) {
        layoutAttributes.append(attributes)
      }
      
      if let decatts = self.layoutAttributesForDecorationView(
        ofKind:self.timeLine, at: IndexPath(item: 0, section: 0)) {
        if rect.contains(decatts.frame) {
          layoutAttributes.append(decatts)
        }
      }
    }
    
    
    return layoutAttributes
  }
  
  override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
    return cache.first { attributes -> Bool in
      return attributes.indexPath == indexPath
    }
  }
  
  override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
    if (!(self.collectionView?.bounds.size.equalTo(newBounds.size))!) {
      return true;
    }
    return false;
  }
  
  override var collectionViewContentSize: CGSize {
    return CGSize(width: self.collectionView!.bounds.size.width, height: contentHeight)
  }
  
}
