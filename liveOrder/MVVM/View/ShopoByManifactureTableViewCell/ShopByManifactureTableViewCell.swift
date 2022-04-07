//
//  ShopByManifactureTableViewCell.swift
//  liveOrder
//
//  Created by Data Prime on 24/08/21.
//

import UIKit

class ShopByManifactureTableViewCell: UITableViewCell {
    @IBOutlet weak var shopbyOverView: UIView!
    @IBOutlet weak var shopByLbl: UILabel!
    @IBOutlet weak var bestManiLbl: UILabel!
    @IBOutlet weak var shopByviewAllBtn: UIButton!
    @IBOutlet weak var shopCollView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        shopCollView.delegate = self
        shopCollView.dataSource = self
        shopCollView.register(UINib(nibName: "ImgCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier:"ImgCollectionViewCell")
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
extension ShopByManifactureTableViewCell : UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let shopByCollCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImgCollectionViewCell", for: indexPath) as! ImgCollectionViewCell
        shopByCollCell.layer.borderColor = hexStringToUIColor(hex: "#c3cde4").cgColor

        shopByCollCell.layer.borderWidth = 0.5

        shopByCollCell.layer.cornerRadius = 5
        
        
        return shopByCollCell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize{
        
        return CGSize(width: 90, height: 90)
        
        
    }

}
