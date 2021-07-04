//
//  cells.swift
//  TicTacToe
//
//  Created by Akshay Jangir on 01/07/21.
//  Copyright © 2021 Akshay Jangir. All rights reserved.
//

import Foundation
import UIKit

class cells: UICollectionViewCell {
    
    private let img:UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        return iv
    }()
    
    func setupCell(with status:Int) {
        contentView.backgroundColor = .init(red: 0.231, green: 0.444, blue: 0.534, alpha: 0.4)
        
        contentView.addSubview(img)
        
        img.frame = CGRect(x: 10, y: 10, width: 60, height: 60)
        
        let name = status == 0 ? "circle" : status == 1 ? "multiply" : ""
        
        contentView.tintColor = status == 0 ? UIColor(red: 0.000, green: 0.844, blue: 0.969, alpha: 1) : status == 1 ? UIColor(red: 0.992, green: 0.260, blue: 0.957, alpha: 1) : .white
        
        img.image = UIImage(systemName: name)
        
    }
    
}
