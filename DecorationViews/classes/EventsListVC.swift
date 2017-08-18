//
//  EventsListVC.swift
//  DecorationViews
//
//  Created by Hellen Soloviy on 8/18/17.
//  Copyright © 2017 Lemberg Solutions Limited. All rights reserved.
//

import UIKit

let identifier = "EventCell"

class EventsListVC: UICollectionViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let flowLayout = CalendarFlowLayout()
    self.collectionView?.collectionViewLayout = flowLayout
    
    self.collectionView?.register(EventCell.self, forCellWithReuseIdentifier: identifier)
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 24
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
    
    if let cell = cell as? EventCell {
      cell.backgroundColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
    }
    
    return cell
  }
  
  
  
}

