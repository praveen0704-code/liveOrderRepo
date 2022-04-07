//
//  ViewController.swift
//  liveOrder
//
//  Created by Data Prime on 29/06/21.
//

import UIKit

class ViewController:  UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var txtLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    var pages = [UIViewController]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
               self.delegate = self
               self.dataSource = self

               let page1: UIViewController! = storyboard?.instantiateViewController(withIdentifier: "IntroViewController")
               let page2: UIViewController! = storyboard?.instantiateViewController(withIdentifier: "SecondIntroViewController")
        
        let page3: UIViewController! = storyboard?.instantiateViewController(withIdentifier: "ThirdIntroVc")
        let page4: UIViewController! = storyboard?.instantiateViewController(withIdentifier: "FourthIntroVC")
        
        let page5: UIViewController! = storyboard?.instantiateViewController(withIdentifier: "FifithIntroVC")
        
  
               pages.append(page1)
               pages.append(page2)
        
        pages.append(page3)
        pages.append(page4)
        pages.append(page5)
        

        setViewControllers([page1], direction: UIPageViewController.NavigationDirection.forward, animated: false, completion: nil)
       
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidLoad()
//        Thread.sleep(forTimeInterval: 3)
//        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "IntroViewController") as? IntroViewController
//        self.navigationController?.navigationBar.isHidden = true
//        self.navigationController?.pushViewController(vc!, animated: true)
       
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
           let currentIndex = pages.index(of: viewController)!
           let previousIndex = abs((currentIndex - 1) % pages.count)
           return pages[previousIndex]
       }

       func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
           let currentIndex = pages.index(of: viewController)!
           let nextIndex = abs((currentIndex + 1) % pages.count)
           return pages[nextIndex]
       }

       func presentationIndex(for pageViewController: UIPageViewController) -> Int {
           return pages.count
       }
    

}

