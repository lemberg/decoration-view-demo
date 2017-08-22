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
  var delegate: CalendarLayoutDelegate?

  override func viewDidLoad() {
    super.viewDidLoad()
    let layout = CalendarLayout()
    self.collectionView?.collectionViewLayout = layout
    delegate = layout
    pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(didReceivePinchGesture))
    self.collectionView?.addGestureRecognizer(pinchGesture!)

  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 20
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
    if let cell = cell as? EventCell {
      cell.backgroundColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
    }
    return cell
  }
  
  func didReceivePinchGesture(gesture: UIPinchGestureRecognizer) {
    delegate?.didReceivePinchGesture(gesture: gesture)    
  }
}
