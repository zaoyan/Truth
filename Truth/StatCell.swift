//
//  StatCell.swift
//  Truth
//
//  Created by David Celentano on 8/30/18.
//  Copyright © 2018 David Celentano. All rights reserved.
//

import UIKit
import SnapKit

class StatCell: UITableViewCell {
    
    let statSwitch = UISwitch()
    let statLabel: UILabel = UILabel.whiteLabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .black
        
        contentView.addSubview(statSwitch)
        statSwitch.snp.makeConstraints { (make) in
            make.top.equalTo(contentView.snp.top).offset(15)
            make.bottom.equalTo(contentView.snp.bottom).offset(-15)
            make.right.equalTo(contentView.snp.right).offset(-15)
        }
        
        contentView.addSubview(statLabel)
        statLabel.snp.makeConstraints { (make) in
            make.top.equalTo(contentView.snp.top).offset(15)
            //make.bottom.equalTo(contentView.snp.bottom).offset(-15)
            make.left.equalTo(contentView.snp.left).offset(15)
            make.right.equalTo(statSwitch.snp.left).offset(-10)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
