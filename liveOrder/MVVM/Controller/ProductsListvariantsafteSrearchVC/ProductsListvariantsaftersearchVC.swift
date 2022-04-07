//
//  ProductsListvariantsaftersearchVC.swift
//  liveOrder
//
//  Created by Data Prime on 06/07/21.
//

import UIKit

class ProductsListvariantsaftersearchVC: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var collectionFullView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var topNaviView: NavigationBarHome!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setup()
        
    }
    func setup (){
        
        
        self.navigationController?.isNavigationBarHidden = true
        let pp = NavigationBarHome.fromNib()

        
        
        pp.frame = CGRect(x: 0, y: -5, width: topNaviView.frame.size.width, height: 150)
        pp.basckView.layer.cornerRadius = 8
        pp.basckView.layer.masksToBounds = true
        
        topNaviView.addSubview(pp)
       
        collectionView.register(UINib(nibName: productlistVariantscelidentifreStr, bundle: Bundle.main), forCellWithReuseIdentifier: productlistVariantscelidentifreStr)
    
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
       
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical //.horizontal
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 12
       
//        topNaviView.applyGradient(colours: [UIColor(hexString: "#674CF3"),UIColor(hexString:"#8039DB")])
        
        pp.overAllView.clipsToBounds = true
        pp.overAllView.layer.cornerRadius = 40
        pp.overAllView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        pp.overAllView.applyGradient(colours: [UIColor(hexString: "#674CF3"),UIColor(hexString:"#8039DB")])
        
        
       
      
    }

    /*
     MARK: - Navigation

     In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         Get the new view controller using segue.destination.
         Pass the selected object to the new view controller.
    }
    */

}
extension ProductsListvariantsaftersearchVC : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let productListCell = collectionView.dequeueReusableCell(withReuseIdentifier: productlistVariantscelidentifreStr, for: indexPath) as! ProductsListofvariantsaftersearchCollCell
        
        productListCell.overAllView.layer.cornerRadius = 5
        return productListCell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1.0, left: 1.0, bottom: 1.0, right: 1.0)//here your custom value for spacing
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let lay = collectionViewLayout as! UICollectionViewFlowLayout
        let widthPerItem = collectionView.frame.width / 2 - lay.minimumInteritemSpacing
        
        return CGSize(width:widthPerItem, height:247)
    }
    
}
