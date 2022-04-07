//
//  MKTabBarVC.swift
//  liveOrder
//
//  Created by Data Prime on 16/09/21.
//

import Foundation


import UIKit

class MKTabBarVC: UIView, UIPageViewControllerDataSource, UIPageViewControllerDelegate, UIScrollViewDelegate, MKTabBarDelegate{
    
    /// Indicator color
    var indicatorColor: UIColor = UIColor.lightGray {
        didSet {
            tabBarView?.indicatorColor = indicatorColor
        }
    }
    
    /// Tab bar button color
    var buttonTitleFontColor: UIColor = UIColor.lightGray {
        didSet {
            tabBarView?.buttonTitleFontColor = buttonTitleFontColor
        }
    }
    
    /// Tab bar selected button color
    var buttonTitleSelectedFontColor: UIColor = UIColor.appprimary {
        didSet {
            tabBarView?.buttonTitleSelectedFontColor = buttonTitleSelectedFontColor
        }
    }
    
    /// Tab bar background color
    var tabBarBackgroundColor: UIColor = UIColor.white {
        didSet {
            tabBarView?.tabBarBackgroundColor = tabBarBackgroundColor
        }
    }
    
    /// Indicator height
    var indicatorHeight: CGFloat = 4 {
        didSet {
            tabBarView?.indicatorHeight = indicatorHeight
        }
    }

    var pages: Array<UIViewController> = Array<UIViewController>()
    var titleForViewController: Array<String> = Array<String>()
    var pageControl = UIPageControl()
    let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    var tabBarView: MKTabBar?
    
    override func layoutSubviews() {
        self.tabBarView?.indicator.frame.size.width = frame.size.width / CGFloat(titleForViewController.count)
        self.tabBarView?.indicator.frame.origin.x = (self.tabBarView?.indicator.frame.size.width)! * CGFloat(pageControl.currentPage)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

        pageViewController.dataSource = self
        pageViewController.delegate = self

        pageViewController.setViewControllers([pages[Constant.initialPage]], direction: .forward, animated: true, completion: nil)
        pageViewController.view.frame = CGRect(x: 0, y: 50, width: self.frame.size.width, height: frame.size.height - CGFloat(Constant.tabBarHeight))

        addSubview(pageViewController.view)

        pageControl = UIPageControl(frame: CGRect(x: frame.origin.x, y: frame.origin.y, width: self.frame.size.width, height: 10.0))
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = Constant.initialPage

        tabBarView = MKTabBar(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: CGFloat(Constant.tabBarHeight)), title: titleForViewController)
        tabBarView?.delegate = self
        addSubview(tabBarView!)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.firstIndex(of: viewController) else {
            return nil
        }
        let previousIndex = viewControllerIndex - 1
        guard previousIndex >= 0 else {
            return nil
        }
        guard pages.count > previousIndex else {
            return nil
        }
        return pages[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.firstIndex(of: viewController) else {
            return nil
        }
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = pages.count
        guard orderedViewControllersCount != nextIndex else {
            return nil
        }
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        return pages[nextIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            pageControl.currentPage = pages.firstIndex(of: (pageViewController.viewControllers?.first)!)!
            tabBarView?.animateIndicator(To: pageControl.currentPage)
        }
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pages.count
    }
    
    func MKTabBarDelegate(didSelectedButtonAt index: Int, with direction: UIPageViewController.NavigationDirection) {
        pageViewController.setViewControllers([pages[index]], direction: direction, animated: true, completion: nil)
        pageControl.currentPage = index
    }
}
