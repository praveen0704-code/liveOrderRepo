//
//  BannerTableViewCell.swift
//  liveOrder
//
//  Created by Data Prime on 23/08/21.
//

import UIKit
let screenSize = UIScreen.main.bounds
let screenWidth = screenSize.width
class BannerTableViewCell: UITableViewCell , UIScrollViewDelegate {
    @IBOutlet weak var overAllView: UIView!
    @IBOutlet weak var bannerCollVIew: UICollectionView!
    @IBOutlet weak var bannerView: UIView!
    
    
//    let scrlView = UIScrollView(frame: CGRect(x:0, y:0, width:screenWidth,height: 128))
//    
//  
//    var pageControl : UIPageControl = UIPageControl(frame: CGRect(x:0,y: 0, width:0, height:0))
//    
//    var immarr : [String] = []
//    
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        
//        bannerCollVIew.delegate = self
//        bannerCollVIew.dataSource = self
//        bannerCollVIew?.scrollToItem(at: IndexPath(row: 0, section: 0),
//                                          at: .top,
////                                    animated: true)
//        bannerCollVIew.register(UINib(nibName: "BannerCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier:"BannerCollectionViewCell")
       
       
//        scrlView.delegate = self
//        scrlView.isPagingEnabled = true
//        scrlView.showsHorizontalScrollIndicator = false
//
//        self.bannerView.addSubview(scrlView)
//
//
//        configurePageControl()
//
//
//
//
//
//
//
//
//        self.scrlView.contentSize = CGSize(width:self.scrlView.frame.size.width * 4,height: self.scrlView.frame.size.height)
//        pageControl.addTarget(self, action: #selector(self.changePage(sender:)), for: UIControl.Event.valueChanged)
    }
//    func loadedData(array : [String]){
//            for index in 0..<array.count {
//                let screenSize = UIScreen.main.bounds
//                let screenWidth = screenSize.width
//                let imgframe: CGRect = CGRect(x:0, y:0, width:screenWidth, height:128)
//
//               let subView = UIImageView(frame: imgframe)
//
//               subView.contentMode = .scaleAspectFit
//                self.scrlView.addSubview(subView)
//
//                let url = URL(string: array[index])
//
//                DispatchQueue.global().async {
//                   // let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
////                    DispatchQueue.main.async {
////                        subView.image = UIImage(data: data!)
////                    }
//                }
//
//
//
//        }
//
//
//
//
//        }
//
//    func configurePageControl() {
//        // The total number of pages that are available is based on how many available colors we have.
//        self.pageControl.numberOfPages = immarr.count
//        self.pageControl.currentPage = 0
//        self.pageControl.tintColor = UIColor.red
//        self.pageControl.pageIndicatorTintColor = UIColor.black
//        self.pageControl.currentPageIndicatorTintColor = UIColor.blue
//        self.bannerView.addSubview(pageControl)
//
//    }
//
//    // MARK : TO CHANGE WHILE CLICKING ON PAGE CONTROL
//    @objc func changePage(sender: AnyObject) -> () {
//        let x = CGFloat(pageControl.currentPage) * scrlView.frame.size.width
//        scrlView.setContentOffset(CGPoint(x:x, y:0), animated: true)
//    }
//
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//
//        let pageNumber = round(scrlView.contentOffset.x / scrlView.frame.size.width)
//        pageControl.currentPage = Int(pageNumber)
//    }
//
//
}
extension BannerTableViewCell : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let bannerCell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCollectionViewCell", for: indexPath) as! BannerCollectionViewCell


        bannerCell.bannerImage.layer.cornerRadius = 5



        return bannerCell
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize{
        
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        return CGSize(width: 300, height: 180)


    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 50
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            let cellWidth : CGFloat = 165.0

            let numberOfCells = floor(collectionView.frame.size.width / cellWidth)
            let edgeInsets = (collectionView.frame.size.width - (numberOfCells * cellWidth)) / (numberOfCells + 1)

        return UIEdgeInsets(top: 15, left: edgeInsets, bottom: 0, right: edgeInsets)
        }
    }


