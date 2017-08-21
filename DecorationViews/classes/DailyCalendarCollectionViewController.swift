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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.collectionView?.collectionViewLayout = CalendarFlowLayout()
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 0
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
