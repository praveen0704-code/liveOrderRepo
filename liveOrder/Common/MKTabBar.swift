//
//  MKTabBar.swift
//  liveOrder
//
//  Created by Data Prime on 15/09/21.
//

import UIKit

protocol MKTabBarDelegate {
    func MKTabBarDelegate(didSelectedButtonAt index: Int, with direction: UIPageViewController.NavigationDirection)
}

class MKTabBar: UIView {
    
    /// Indicator color
    var indicatorColor: UIColor = UIColor.lightGray
    
    /// Tab bar button color
    var buttonTitleFontColor: UIColor = UIColor.lightGray
    
    /// Tab bar selected button color
    var buttonTitleSelectedFontColor: UIColor = UIColor.init(hexString: "674cf3")
    
    /// Tab bar background color
    var tabBarBackgroundColor: UIColor = UIColor.white
    
    /// Indicator height
    var indicatorHeight: CGFloat = 3
    
    var titleForViewController: Array<String> = Array<String>()
    var indicator = UIView()
    var stackView = UIStackView()
    var delegate: MKTabBarDelegate?
    var selectedIndex = Constant.initialPage
    var arrayButtonTitle = [UIButton]()
    
    init(frame: CGRect, title: [String]) {
        super.init(frame: frame)
        
        self.titleForViewController = title
        self.autoresizingMask = [.flexibleWidth]
        self.backgroundColor = tabBarBackgroundColor
        
        stackView = UIStackView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        stackView.autoresizingMask = [.flexibleWidth]
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = true
        for title in titleForViewController {
            let button = UIButton(type: .system)
            button.tintColor = buttonTitleFontColor
            button.setTitle(title, for: .normal)
            stackView.addArrangedSubview(button)
            button.tag = titleForViewController.firstIndex(of: title)!
            button.addTarget(self, action: #selector(selectedButton(_:)), for: UIControl.Event.touchUpInside)
            
            arrayButtonTitle.append(button)
        }
        addSubview(stackView)
        
        indicator = UIView(frame: CGRect(x: 0, y: frame.size.height - 4, width: frame.size.width / CGFloat(titleForViewController.count), height: indicatorHeight))
        indicator.backgroundColor = UIColor.init(hexString: "674cf3")
        addSubview(indicator)
        
        changeButtonTitleColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.autoresizingMask = [.flexibleWidth]
        self.backgroundColor = UIColor.yellow
        
        stackView = UIStackView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        stackView.autoresizingMask = [.flexibleWidth]
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = true
        for title in titleForViewController {
            let button = UIButton(type: .system)
            button.setTitle(title, for: .normal)
            stackView.addArrangedSubview(button)
            button.tag = titleForViewController.firstIndex(of: title)!
            button.addTarget(self, action: #selector(selectedButton(_:)), for: UIControl.Event.touchUpInside)
        }
        addSubview(stackView)
        
        /// adding indicator for making selection
        indicator = UIView(frame: CGRect(x: 0, y: frame.size.height - 5, width: frame.size.width / CGFloat(titleForViewController.count), height: 5))
        indicator.backgroundColor = UIColor.blue
        addSubview(indicator)
    }
    
    @objc func selectedButton(_ sender: UIButton) {
        if selectedIndex < sender.tag {
            delegate?.MKTabBarDelegate(didSelectedButtonAt: sender.tag, with: .forward)
        }else if selectedIndex > sender.tag {
            delegate?.MKTabBarDelegate(didSelectedButtonAt: sender.tag, with: .reverse)
        }
        animateIndicator(To: sender.tag)
    }
    
    func animateIndicator(To index: Int) {
        UIWindow.animate(withDuration: 0.2) {
            self.indicator.frame.origin.x = self.indicator.frame.size.width * CGFloat(index)
        }
        selectedIndex = index
        changeButtonTitleColor()
    }
    
    func changeButtonTitleColor() {
        for i in 0 ..< titleForViewController.count {
            let button = arrayButtonTitle[i]
            if i == selectedIndex {
                button.setTitleColor(buttonTitleSelectedFontColor, for: .normal)
            }else {
                button.setTitleColor(buttonTitleFontColor, for: .normal)
            }
        }
    }
}
