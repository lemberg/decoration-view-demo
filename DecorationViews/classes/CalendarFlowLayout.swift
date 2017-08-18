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
  
  private let timeLine = "TimeLine"
  private let timeLineHeight: CGFloat = 10
  private var eventHeight: CGFloat = 30
  private var numberOfItems: Int {
    return collectionView!.numberOfItems(inSection: 0)
  }
  
  private var collectionViewWidth: CGFloat {
    return collectionView!.bounds.width
  }
  
  override init() {
    super.init()
    register(TimeLineGrid.self, forDecorationViewOfKind: self.timeLine)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private var cache = [UICollectionViewLayoutAttributes]()
  
  private var decorationAttributes: [UICollectionViewLayoutAttributes] {
    var attributes: [UICollectionViewLayoutAttributes] = []
    for item in 0..<numberOfItems {
      let indexPath = IndexPath(item: item, section: 0)
      if let decatts = self.layoutAttributesForDecorationView(ofKind:self.timeLine, at: indexPath) {
        attributes.append(decatts)
      }
    }
    return attributes
  }
  
  override func prepare() {
    super.prepare()
    if cache.isEmpty {
      cache.append(contentsOf: decorationAttributes)
    }
  }
  
  override func layoutAttributesForDecorationView( ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
    let atts = UICollectionViewLayoutAttributes(forDecorationViewOfKind:timeLine, with:indexPath)
    atts.frame = CGRect(x: 0, y: CGFloat(indexPath.item) * (timeLineHeight + eventHeight), width: collectionViewWidth, height: timeLineHeight)
    atts.zIndex = -1
    return atts
  }
  
  
  override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    var layoutAttributes = [UICollectionViewLayoutAttributes]()
    
    for attributes in cache {
      if attributes.frame.intersects(rect) {
        layoutAttributes.append(attributes)
      }
    }
    
    return layoutAttributes
  }
  
  override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
    return cache.first { attributes -> Bool in
      return attributes.indexPath == indexPath
    }
  }
  
  override var collectionViewContentSize: CGSize {
    return CGSize(width: collectionViewWidth, height: (timeLineHeight + eventHeight) * CGFloat(numberOfItems))
  }
  
}
