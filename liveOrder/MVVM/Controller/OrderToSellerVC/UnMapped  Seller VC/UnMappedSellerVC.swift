//
//  UnMappedSellerVC.swift
//  liveOrder
//
//  Created by Data Prime on 15/09/21.
//

import UIKit

class UnMappedSellerVC: UIViewController,retrivalDelegate {
    func retrivetapped(type: String) {
        DispatchQueue.main.async {
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "OrderToSellFiltterVC") as? OrderToSellFiltterVC
//            self.navigationController?.navigationBar.isHidden = true
//            self.navigationController?.pushViewController(vc!, animated: true)
            let root = UINavigationController(rootViewController: vc!)
             root.navigationBar.isHidden = true
             root.modalPresentationStyle = .fullScreen
             self.present(root, animated: true, completion: nil)
        }
     
    }
    
    @IBOutlet weak var listOfLbl: UILabel!
    @IBOutlet weak var unMappedTableView: UITableView!
    @IBOutlet weak var moreBtn: UIButton!
    
    let RetrievalOptionView = UINib(nibName: "RetrievalOptionView", bundle:
                        nil).instantiate(withOwner: nil, options: nil)[0] as? RetrievalOptionView
    override func viewDidLoad() {
        super.viewDidLoad()
        RetrievalOptionView?.delegate = self
        // Do any additional setup after loading the view.
        unMappedTableView.delegate = self
        unMappedTableView.dataSource = self
        unMappedTableView.register(UINib(nibName: "UMSTableCell", bundle: nil), forCellReuseIdentifier: "UMSTableCell")
    }
    
    @IBAction func moreBtnAct(_ sender: Any) {
        
        self.RetrievalOptionView!.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        
        self.view.addSubview(self.RetrievalOptionView!)
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
extension UnMappedSellerVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            
            let UMSTableCell = tableView.dequeueReusableCell(withIdentifier: "UMSTableCell", for: indexPath)as! UMSTableCell
        
            return UMSTableCell
            
        
    }
}
