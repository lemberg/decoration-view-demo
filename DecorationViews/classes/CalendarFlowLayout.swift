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
  
}

class CalendarFlowLayout: UICollectionViewFlowLayout {
  
  var delegate: CalendarFlowLayoutDelegate!
  
  private let timeLine = "TimeLine"
  private let overlayValue: CGFloat = 4
  private let timeLineHeight: CGFloat = 10

  
  private let eventHeignt: CGFloat = 40
  private var timeLineSpace: CGFloat {
    return eventHeignt - 2 * overlayValue
  }
  
  private var decorationViewLeftInset: CGFloat {
    return 16
  }
  
  private var hours: Int {
    return 24
  }
  
  private var leftEventInset: CGFloat {
    return 40 + decorationViewLeftInset
  }
  
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
    for item in 0..<hours {
      let indexPath = IndexPath(item: item, section: 0)
      if let decatts = self.layoutAttributesForDecorationView(ofKind:self.timeLine, at: indexPath) {
        attributes.append(decatts)
      }
    }
    return attributes
  }
  
  var eventsAttributes: [UICollectionViewLayoutAttributes] {
    var attributes: [UICollectionViewLayoutAttributes] = []
    for item in 0..<numberOfItems {
      let indexPath = IndexPath(item: item, section: 0)
      let attr = UICollectionViewLayoutAttributes(forCellWith: indexPath)
      attr.frame = CGRect(x: leftEventInset, y: CGFloat(item) * (eventHeignt + timeLineHeight - 2*overlayValue) + timeLineHeight - overlayValue , width: collectionViewWidth-leftEventInset, height: eventHeignt)
      attr.zIndex = 1
      attr.alpha = 0.6
      attributes.append(attr)
    }
    return attributes
  }
  
  override func prepare() {
    super.prepare()
    if cache.isEmpty {
      cache.append(contentsOf: decorationAttributes)
      cache.append(contentsOf: eventsAttributes)
    }
  }
  
  override func layoutAttributesForDecorationView( ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
    let atts = UICollectionViewLayoutAttributes(forDecorationViewOfKind:timeLine, with:indexPath)
    atts.frame = CGRect(x: decorationViewLeftInset, y: CGFloat(indexPath.item) * (timeLineHeight + timeLineSpace), width: collectionViewWidth - decorationViewLeftInset, height: timeLineHeight)
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
    return CGSize(width: collectionViewWidth, height: (timeLineHeight + timeLineSpace) * CGFloat(hours) - timeLineSpace)
  }
  
}
