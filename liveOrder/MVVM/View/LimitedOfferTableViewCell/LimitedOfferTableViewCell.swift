//
//  LimitedOfferTableViewCell.swift
//  liveOrder
//
//  Created by Data Prime on 24/08/21.
//

import UIKit

class LimitedOfferTableViewCell: UITableViewCell {
    @IBOutlet weak var limitedOverView: UIView!
    @IBOutlet weak var limitedLbl: UILabel!
    @IBOutlet weak var pickBestLbl: UILabel!
    @IBOutlet weak var limitedViewAllBtn: UIButton!
    @IBOutlet weak var limitedOffersCollView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        limitedOffersCollView.delegate = self
        limitedOffersCollView.dataSource = self
        limitedOffersCollView.register(UINib(nibName: "LimitedPeriodCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier:"LimitedPeriodCollectionViewCell")
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
extension LimitedOfferTableViewCell : UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let limitedCollCell = collectionView.dequeueReusableCell(withReuseIdentifier: "LimitedPeriodCollectionViewCell", for: indexPath) as! LimitedPeriodCollectionViewCell
        limitedCollCell.limitedImgView.layer.cornerRadius = 15
        
        
        return limitedCollCell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize{
        
        return CGSize(width: 255, height: 130)
        
        
    }

}
