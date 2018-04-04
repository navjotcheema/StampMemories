//
//  dashBoardTableViewCell.swift
//  StampMemories
//
//  Created by Apple on 22/03/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

class dashBoardTableViewCell: UITableViewCell {
    @IBOutlet weak var parentCatCollectionView: UICollectionView!
    
    @IBOutlet weak var button1: UIButton!
    
    @IBOutlet weak var button2: UIButton!
    
    @IBOutlet weak var button3: UIButton!
    
    
    @IBOutlet weak var button4: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
extension dashBoardTableViewCell {
    
    func setCollectionViewDataSourceDelegate<D: UICollectionViewDataSource & UICollectionViewDelegate>(_ dataSourceDelegate: D, forRow row: Int) {
        
        parentCatCollectionView.delegate = dataSourceDelegate
        parentCatCollectionView.dataSource = dataSourceDelegate
        parentCatCollectionView.tag = row
//        parentCatCollectionView.setContentOffset(parentCatCollectionView.contentOffset, animated:false) // Stops collection view if it was scrolling.
        parentCatCollectionView.reloadData()
    }
    
    var collectionViewOffset: CGFloat {
        set { parentCatCollectionView.contentOffset.x = newValue }
        get { return parentCatCollectionView.contentOffset.x }
    }
}
