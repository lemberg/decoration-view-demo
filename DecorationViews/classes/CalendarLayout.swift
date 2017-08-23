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
  
  private var startGestureLocation: CGPoint = CGPoint()
  private var startContentHeight: CGFloat = CGFloat()
  private var gestureOffsetY = CGFloat()
  
  let minZoom: CGFloat = 0.7
  let maxZoom: CGFloat = 2.0
  
  private var eventHeignt: CGFloat = 40
  
  private var scale: CGFloat = 1.0 {
    didSet {
      if scale <= minZoom || scale >= maxZoom {
        scale = oldValue
      }
    }
  }
  
  private var startScale: CGFloat = 1.0
  
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
  private var contentOffsetY: CGFloat {
    return collectionViewContentSize.height - collectionView!.bounds.height
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
    return CGSize(width: collectionViewWidth, height: ((timeLineHeight + timeLineSpace) * CGFloat(hours+1) - timeLineSpace + topContentInset + bottomContentInset))
  }
  
  func didReceivePinchGesture(gesture: UIPinchGestureRecognizer) {
    
    if gesture.state == .began {
      startScale = self.scale
      startGestureLocation = gesture.location(in: nil)
      startContentHeight = collectionView!.bounds.height
      return
    }
    
    if gesture.state == .changed {
      scale = startScale * gesture.scale
      eventHeignt = defaultEventHeight * scale
      
      let contentHeight = collectionViewContentSize.height //size depend on cells
      let collectionViewHeight = collectionView!.bounds.height //fixed bounds
      let gestureCenterY = gesture.location(in: nil).y
      
      gestureOffsetY = contentHeight / 2 - gestureCenterY
      
      if (gestureOffsetY > -collectionView!.contentInset.top && gestureOffsetY < contentOffsetY) {
        let centerZoomPointY = (contentHeight - collectionViewHeight) / CGFloat(2)
        print(" (\(contentHeight) - \(collectionViewHeight) / 2) = \(centerZoomPointY)")
        
        
        collectionView?.setContentOffset(CGPoint(x: 0, y: gestureOffsetY), animated: false)
        
        print("gestureCenter =\(gestureCenterY) & contentHeight = \(contentHeight)")
        print("--------------------------------------------------------")
        print(" gestureOffsetY = \(gestureOffsetY) ")
        print("--------------------------------------------------------")
        print("collectionView!.contentSize.height - collectionView!.bounds = \(collectionViewContentSize.height - collectionView!.bounds.height) & collectionViewContentInset = \(collectionView!.contentInset)")
        print("--------------------------------------------------------")
        
      }
      cache = []
      
      invalidateLayout()
    }
    
    //    if gesture.state == .ended {
    //      if gestureOffsetY < 0 {
    //        collectionView?.setContentOffset(CGPoint(x: 0, y: -collectionView!.contentInset.top), animated: true)
    //      }
    //      if gestureOffsetY > contentOffsetY {
    //        collectionView?.setContentOffset(CGPoint(x: 0, y: contentOffsetY), animated: true)
    //      }
    //      print("Ended")
    //    }
  }
}
