//
//  TimeLineGrid.swift
//  DecorationViews
//
//  Created by Hellen Soloviy on 8/18/17.
//  Copyright © 2017 Lemberg Solutions Limited. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class TimeLineGrid: UICollectionReusableView {
    
    var date: Date = Date()
    var timeLabel: UILabel = UILabel()
    var line: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        line = UIView(frame: CGRect(x: 0, y: 0, width: bounds.width, height: 1))
        timeLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: frame.height))
        timeLabel.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        timeLabel.font = UIFont(name: "GillSans-Bold", size: 40)
        timeLabel.text = "00:00"
        self.backgroundColor = #colorLiteral(red: 0.4352941215, green: 0.4431372583, blue: 0.4745098054, alpha: 1)
        self.addSubview(timeLabel)
        self.addSubview(line)
      
//        let timeLabelWidth = 50
//        
//        self.timeLabel.snp.makeConstraints { (make) -> Void in
//            make.width.equalTo(timeLabelWidth)
//            make.height.equalTo(frame.height)
//        }
//
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
