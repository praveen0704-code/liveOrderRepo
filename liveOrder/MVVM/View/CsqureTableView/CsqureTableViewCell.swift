//
//  CsqureTableViewCell.swift
//  liveOrder
//
//  Created by Data Prime on 24/08/21.
//

import UIKit

class CsqureTableViewCell: UITableViewCell {
   
    @IBOutlet weak var cSqureOverView: UIView!
    @IBOutlet weak var csqureLbl: UILabel!
    @IBOutlet weak var increseLbl: UIView!
    @IBOutlet weak var csqureCollView: UICollectionView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        csqureCollView.delegate = self
        csqureCollView.dataSource = self
        csqureCollView.register(UINib(nibName: "CsquareCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier:"CsquareCollectionViewCell")
      
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
extension CsqureTableViewCell : UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let limitedCollCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CsquareCollectionViewCell", for: indexPath) as! CsquareCollectionViewCell
        
        
        
        return limitedCollCell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize{
        
        return CGSize(width: 255, height: 150)
        
        
    }

}
