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

//class TimeViewLayoutAttributes : UICollectionViewLayoutAttributes {
//    var time = ""
//}

class TimeLineGrid: UICollectionReusableView {
    
    var date: Date = Date()
    var timeLabel: UILabel = UILabel()
    var line: UIView
    
    override init(frame: CGRect) {
        
        line = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: frame.height))
        timeLabel.text = "00:00"
        
        super.init(frame: frame)

        self.backgroundColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
        
//        self.addSubview(line)
        self.addSubview(timeLabel)

        let timeLabelWidth = 50
        self.timeLabel.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(timeLabelWidth)
            make.height.equalTo(frame.height)
        }
//
//        self.line.snp.makeConstraints { (make) -> Void in
//            make.right.equalTo(0)
//            make.height.equalTo(1)
//            make.centerY.equalTo(self.center.y)
//            make.leading.equalTo(timeLabelWidth)
//
//        }

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
