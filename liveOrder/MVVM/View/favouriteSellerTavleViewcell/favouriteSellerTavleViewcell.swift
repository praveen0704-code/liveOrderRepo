//
//  favouriteSellerTavleViewcell.swift
//  liveOrder
//
//  Created by Data Prime on 23/08/21.
//

import UIKit
import Kingfisher

class favouriteSellerTavleViewcell: UITableViewCell {
    @IBOutlet weak var overAllView: UIView!
    @IBOutlet weak var sellerLbl: UILabel!
    @IBOutlet weak var pickLbl: UILabel!
    @IBOutlet weak var viewAllBtn: UIButton!
    @IBOutlet weak var sellerCollView: UICollectionView!
    
    var listValue : [S_seller_lists] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        sellerCollView.delegate = self
        sellerCollView.dataSource = self
        sellerCollView.register(UINib(nibName: "favouriteSellerCollCell", bundle: Bundle.main), forCellWithReuseIdentifier:"favouriteSellerCollCell")
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        let cellSize = CGSize(width:screenWidth/2 - 70 , height:111)

            let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal //.vertical //.
            layout.itemSize = cellSize
            layout.sectionInset = UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
            layout.minimumLineSpacing = 10
            layout.minimumInteritemSpacing = 10
        sellerCollView.setCollectionViewLayout(layout, animated: true)

        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func seller(data : [S_seller_lists]){
        listValue = data
        
        sellerCollView.reloadData()
    }
    
}
extension favouriteSellerTavleViewcell: UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listValue.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sellercell = collectionView.dequeueReusableCell(withReuseIdentifier: "favouriteSellerCollCell", for: indexPath) as! favouriteSellerCollCell
        
        sellercell.titleLabel.text  = listValue[indexPath.row].c_seller_name
       
        let url = URL(string: listValue[indexPath.row].c_seller_image!)
        sellercell.imgView.kf.setImage(with: url)
        return sellercell
    }
    
//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        sizeForItemAt indexPath: IndexPath) -> CGSize{
//
//        return CGSize(width: 75, height: 119)
        
        
//    }
}
