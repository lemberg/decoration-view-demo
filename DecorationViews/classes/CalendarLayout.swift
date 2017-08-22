//
//  EventsFlowLayout.swift
//  DecorationViews
//
//  Created by Hellen Soloviy on 8/18/17.
//  Copyright © 2017 Lemberg Solutions Limited. All rights reserved.
//

import Foundation
import UIKit

protocol CalendarLayoutDelegate {
  func didReceivePinchGesture(gesture: UIPinchGestureRecognizer)
}

class CalendarLayout: UICollectionViewLayout, CalendarLayoutDelegate {
  
  private let overlayValue: CGFloat = 4
  private let timeLineHeight: CGFloat = 10
  private let topContentInset: CGFloat = 10
  private let bottomContentInset: CGFloat = 10
  private let defaultEventHeight: CGFloat = 40
    
  let minZoom: CGFloat = 2.0
  let maxZoom: CGFloat = 0.5
  
  private var eventHeignt: CGFloat = 40
  
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
    eventHeignt = 40
    register(TimeLineGridView.self, forDecorationViewOfKind: Kind.timeLine)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private var cache = [UICollectionViewLayoutAttributes]()
  
  private var decorationAttributes: [UICollectionViewLayoutAttributes] {
    var attributes: [UICollectionViewLayoutAttributes] = []
    for item in 0...hours {
      let indexPath = IndexPath(row: item, section: 0)
      let atts = TimeLineGridViewLayoutAttributes(forDecorationViewOfKind: Kind.timeLine, with: indexPath)
      atts.item = item
      atts.frame = CGRect(x: decorationViewLeftInset, y: CGFloat(indexPath.item) * (timeLineHeight + timeLineSpace) + topContentInset, width: collectionViewWidth - decorationViewLeftInset, height: timeLineHeight)
      atts.zIndex = -1
      attributes.append(atts)
    }
    return attributes
  }
  
  var eventsAttributes: [UICollectionViewLayoutAttributes] {
    var attributes: [UICollectionViewLayoutAttributes] = []
    for item in 0..<numberOfItems {
      let indexPath = IndexPath(item: item, section: 0)
      let attr = UICollectionViewLayoutAttributes(forCellWith: indexPath)
      attr.frame = CGRect(x: leftEventInset, y: CGFloat(item) * (eventHeignt + timeLineHeight - 2 * overlayValue) + timeLineHeight - overlayValue + topContentInset, width: collectionViewWidth - leftEventInset, height: eventHeignt)
      attr.zIndex = 1
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
    return CGSize(width: collectionViewWidth, height: (timeLineHeight + timeLineSpace) * CGFloat(hours+1) - timeLineSpace + topContentInset + bottomContentInset)
  }
  
  func didReceivePinchGesture(gesture: UIPinchGestureRecognizer) {
    
    
    if gesture.state == .began {
    }
    
    if gesture.state == .changed {
      if gesture.scale <= maxZoom {
        return
      }
      
      if gesture.scale >= minZoom {
        return
      }
      eventHeignt = defaultEventHeight * gesture.scale
      cache = []
      invalidateLayout()
    }
  }
  
  
  override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
    return super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity)
  }
  
  override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
    return proposedContentOffset
  }
}
