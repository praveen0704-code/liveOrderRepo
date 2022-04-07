//
//  AlterTableCell.swift
//  liveOrder
//
//  Created by Data Prime on 04/09/21.
//

import UIKit

class AlterTableCell: UITableViewCell {
    @IBOutlet weak var overView: UIView!
    @IBOutlet weak var alterLbl: UILabel!
    @IBOutlet weak var viewAllBtn: UIButton!
    @IBOutlet weak var alterTableView: UITableView!
    @IBOutlet weak var alterCollView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        alterCollView.delegate = self
        alterCollView.dataSource = self
        alterCollView.register(UINib(nibName: "AlternatesCollCell", bundle: Bundle.main), forCellWithReuseIdentifier:"AlternatesCollCell")
    }
    @IBAction func viewAllBtnAct(_ sender: Any) {
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
extension AlterTableCell : UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
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
        
        return CGSize(width: 159, height: 240)
        
        
    }

}
