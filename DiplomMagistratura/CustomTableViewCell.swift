//
//  CustomTableViewCell.swift
//  DiplomMagistratura
//
//  Created by Admin on 05.03.17.
//  Copyright © 2017 SergeyPilipenko. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureCell()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
    }
    
    let label: UILabel = {
        let lb = UILabel()
        lb.textColor = UIColor.red
        lb.frame = CGRect(x: 10, y: 10, width: 50, height: 15)
        return lb
    }()
    
    func configureCell(){
        addSubview(label)
    }

}
