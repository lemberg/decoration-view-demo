//
//  EventsListVC.swift
//  DecorationViews
//
//  Created by Hellen Soloviy on 8/18/17.
//  Copyright © 2017 Lemberg Solutions Limited. All rights reserved.
//

import UIKit

let identifier = "EventCell"

class DailyCalendarCollectionViewController: UICollectionViewController {
    
    var pinchGesture: UIPinchGestureRecognizer?
//    var scale =
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let flow = CalendarFlowLayout()
    flow.delegate = self
    self.collectionView?.collectionViewLayout = flow
    
    pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(didReceivePinchGesture))
    self.collectionView?.addGestureRecognizer(pinchGesture!)
    
  }
    
    func didReceivePinchGesture(gesture: UIPinchGestureRecognizer) {
        
        var scaleStart: CGFloat = 0.0
        
        if gesture.state == .began {
            scaleStart = self.collectionView!.zoomScale
            return
        }
        
        if gesture.state == .changed {
            self.collectionView!.zoomScale = scaleStart * gesture.scale
            self.collectionView?.collectionViewLayout.invalidateLayout()
            
        }
        
    }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 10
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
    if let cell = cell as? EventCell {
      cell.backgroundColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
    }
    return cell
  }
    
  override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    var view: UICollectionReusableView
    
    if kind == Kind.timeLine {
      let columnHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: String(describing: TimeLineGridView.self), for: indexPath) as! TimeLineGridView
      columnHeader.indexPath = indexPath
      view = columnHeader
    } else {
      view = UICollectionReusableView()
    }
    
    return view
  }
}

extension DailyCalendarCollectionViewController: CalendarFlowLayoutDelegate {
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        
//        guard let collectionView = self.collectionView else {
//            print("No collection view")
//            return CGSize(width: 20, height: 20)
//        }
//        
//        var scaleWidth = 200 * collectionView.zoomScale
//        var scaleHeight = 44 * collectionView.zoomScale
//        
//        return CGSize(width: scaleWidth, height: scaleHeight)
//        
//    }
    
}

