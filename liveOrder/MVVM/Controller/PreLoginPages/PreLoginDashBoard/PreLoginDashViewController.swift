//
//  PreLoginDashViewController.swift
//  liveOrder
//
//  Created by PraveenMac on 03/07/21.
//

import UIKit

class PreLoginDashViewController: UIViewController {
    
    @IBOutlet weak var pSearchTextfield: UITextField!
    @IBOutlet weak var preLoginScrollView: UIScrollView!
    @IBOutlet weak var preLoginCollectionView:UICollectionView!
    
    @IBOutlet weak var topSearchMedCollectionView: UICollectionView!
    
    @IBOutlet weak var newLaunchCollectionView: UICollectionView!
    
    @IBOutlet weak var tSViewButton: UIButton!
    
    @IBOutlet weak var nlViewAllButton: UIButton!
    
    @IBOutlet weak var keyHeighlightsCollectionView: UICollectionView!
    
    @IBOutlet weak var pLoginButton: UIButton!
    
    @IBOutlet weak var registerUsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        preLoginDashboardLoadView()
        
    }
    //MARK: - LoadView
    
    func preLoginDashboardLoadView(){
       
        self.preLoginScrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
        
       self.preLoginCollectionView.register(UINib(nibName: pBannerCollectionCellIdentifierStr, bundle: Bundle.main), forCellWithReuseIdentifier:pBannerCollectionCellIdentifierStr)
        self.topSearchMedCollectionView.register(UINib(nibName: pTopSearchCollCellIdentifierStr, bundle: Bundle.main), forCellWithReuseIdentifier:pTopSearchCollCellIdentifierStr)
        self.newLaunchCollectionView.register(UINib(nibName: pTopSearchCollCellIdentifierStr, bundle: Bundle.main), forCellWithReuseIdentifier:pTopSearchCollCellIdentifierStr)
        
        self.keyHeighlightsCollectionView.register(UINib(nibName: pHighLightsCEllIdentifierStr, bundle: Bundle.main), forCellWithReuseIdentifier:pHighLightsCEllIdentifierStr)
        
        
        
       // KeyHighlightsCollectionViewCell

        self.preLoginCollectionView.delegate = self
        self.preLoginCollectionView.dataSource = self
        self.topSearchMedCollectionView.delegate = self
        self.topSearchMedCollectionView.dataSource = self
        self.newLaunchCollectionView.delegate = self
        self.newLaunchCollectionView.dataSource = self
        self.keyHeighlightsCollectionView.delegate = self
        self.keyHeighlightsCollectionView.dataSource = self
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical //.horizontal
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        keyHeighlightsCollectionView.setCollectionViewLayout(layout, animated: true)
        
        
        pSearchTextfield.withImage(direction:.Left, image: UIImage(named: "search_icon")!, colorSeparator: UIColor.lightGray, colorBorder: UIColor.black)
        
        pSearchTextfield.withImage(direction:.Right, image: UIImage(named: "microphone_1")!, colorSeparator: UIColor.lightGray, colorBorder: UIColor.black)
        
        
        


        
    }
    
    //MARK: - Button Action
    
    @IBAction func tPViewAllAction(_ sender: Any) {
        
    }
    
    @IBAction func nLViewAllAction(_ sender: Any) {
        
    }
    
    @IBAction func loginAction(_ sender: Any) {
        
    }
    
    @IBAction func registerUsAction(_ sender: Any) {
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension PreLoginDashViewController:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == preLoginCollectionView{
            
            
            let pcell = collectionView.dequeueReusableCell(withReuseIdentifier: "PrductBannerCollectionViewCell", for: indexPath)
         //   let pBCollnCell = collectionView.dequeueReusableCell(withReuseIdentifier: pBannerCollectionCellIdentifierStr, for: indexPath) as! PrductBannerCollectionViewCell
        
          //  pBCollnCell.DiscountLabel.attributedText = fonntBoldAttribute(fullStr: "Flat 25% Off On All Cardiac Division Products", boldStr: "25% Off", fullColor: UIColor(hexString: "#272727"), boldColor: UIColor(hexString: "#ac0020"),fullStringfSize:12,boldStrSize:15)
        
           // pBCollnCell.backgroundColor = UIColor.white
           
            return pcell
        } else if collectionView == topSearchMedCollectionView {
            
            let pTmCollCell = collectionView.dequeueReusableCell(withReuseIdentifier: pTopSearchCollCellIdentifierStr, for: indexPath) as! TopSearchCollectionViewCell
            pTmCollCell.offerLabel.isHidden = true
            pTmCollCell.addLabel.isHidden = true
            pTmCollCell.proContailsLabel.isHidden = false
            pTmCollCell.comPanyNameLabel.isHidden = true
        
          return pTmCollCell
        }else if collectionView == newLaunchCollectionView {
            
            let pTmCollCell = collectionView.dequeueReusableCell(withReuseIdentifier: pTopSearchCollCellIdentifierStr, for: indexPath) as! TopSearchCollectionViewCell
            pTmCollCell.offerLabel.isHidden = true
            pTmCollCell.addLabel.isHidden = true
            pTmCollCell.containerLabel.isHidden = true
            pTmCollCell.proContailsLabel.isHidden = true
            pTmCollCell.comPanyNameLabel.isHidden = false

        
          return pTmCollCell
            
        }else{
            
            
            let pNewHighlightscollCEll = collectionView.dequeueReusableCell(withReuseIdentifier: pHighLightsCEllIdentifierStr, for: indexPath) as! KeyHighlightsCollectionViewCell
        
           
        
          return pNewHighlightscollCEll
        }

       
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1.0, left: 1.0, bottom: 1.0, right: 1.0)//here your custom value for spacing
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let lay = collectionViewLayout as! UICollectionViewFlowLayout
        let widthPerItem = collectionView.frame.width / 2 - lay.minimumInteritemSpacing
        
        return CGSize(width:widthPerItem, height:100)
    }
    
  
    
    
}
