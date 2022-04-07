//
//  CartFifthVC.swift
//  liveOrder
//
//  Created by Data Prime on 14/09/21.
//

import UIKit

class CartFifthVC: UITableViewCell {
    @IBOutlet weak var overView: UIView!
    @IBOutlet weak var suggestLbl: UILabel!
    @IBOutlet weak var cartCollView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cartCollView.delegate = self
        cartCollView.dataSource = self
        cartCollView.register(UINib(nibName: "AlternatesCollCell", bundle: Bundle.main), forCellWithReuseIdentifier:"AlternatesCollCell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
extension CartFifthVC : UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let alterCell = collectionView.dequeueReusableCell(withReuseIdentifier: "AlternatesCollCell", for: indexPath) as! AlternatesCollCell
        alterCell.redBtn.isHidden = true
        
        return alterCell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize{
        
        return CGSize(width: 159, height: 285)
        
        
    }

}
