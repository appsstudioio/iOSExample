//
//  BaseTabBarController.swift
//  iOSExample
//
//  Created by dongju.lim on 2023/02/13.
//

import UIKit
import SnapKit
import Then

class BaseTabBarController: UITabBarController {
    
    var defaultIndex = 0 {
        didSet{
            self.selectedIndex = defaultIndex
        }
    }
    var preVC: UIViewController?
    
    public override var selectedIndex: Int {
        didSet {
            self.moveLine()
        }
    }
#if DEVELOP
    var preSelectIndex: Int = 0
    var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.named(.mainColor)
        view.layer.cornerRadius = 1
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = true
        return view
    }()
#endif

    override func loadView() {
        super.loadView()
        setTapBarViewControllers()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    private func moveLine() {
#if DEVELOP
       if let tabbarItems = self.tabBar.items {
           let tabSize = (tabBar.frame.size.width / CGFloat(tabbarItems.count))
           let tabBarStart = tabBar.frame.origin.x

           if preSelectIndex > self.selectedIndex {
               // move left
               self.lineView.layer.moveInAnimation(duration: 0.4,
                                                   subtype: .fromRight,
                                                   timingFunction: .default,
                                                   transitionType: .moveIn)
           } else if preSelectIndex < self.selectedIndex {
               // move right
               self.lineView.layer.moveInAnimation(duration: 0.4,
                                                   subtype: .fromLeft,
                                                   timingFunction: .default,
                                                   transitionType: .moveIn)
           }
           preSelectIndex = self.selectedIndex

           // Assume index of tabs starts at 0, then the tab in your pic would be tab 4
           //   targetX would be the center point of the target tab.
           let targetX = tabBarStart + (tabSize * CGFloat(self.selectedIndex))
           self.lineView.frame = CGRect(x: (targetX + 16), y: 0, width: (tabSize - 32), height: 1.5)
       }
#endif
    }
}

extension BaseTabBarController {
    
    private func setTapBarViewControllers() {
        
        view.backgroundColor = UIColor.named(.backgroundColor)
        let unSeletImageColor = UIColor.lightGray
        let seletImageColor = UIColor.named(.mainColor)

        let tabBar: UITabBar = self.tabBar
        tabBar.backgroundColor = UIColor.named(.backgroundColor)
        tabBar.barTintColor = UIColor.named(.backgroundColor)
        ///선택되었을 때 타이틀 컬러
        tabBar.tintColor = seletImageColor
        ///선택안된거 타이틀 컬러
        tabBar.unselectedItemTintColor = unSeletImageColor
        tabBar.isHidden = false
        tabBar.isTranslucent = false

        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.backgroundColor = UIColor.named(.backgroundColor)
        tabBarAppearance.shadowImage = UIImage.colorToBackgroundImage(UIColor.named(.borderOpaque))
        tabBarAppearance.backgroundImage = UIImage.colorToBackgroundImage(UIColor.named(.backgroundColor))
        UITabBar.appearance().standardAppearance = tabBarAppearance

        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        }

        let attributes: [NSAttributedString.Key : Any] = [.font: ComponentFont.font(weight: .regular, size: 10) as Any,
                                                          .foregroundColor: unSeletImageColor as Any]

        let attributesSelect: [NSAttributedString.Key : Any] = [.font: ComponentFont.font(weight: .semibold, size: 10) as Any,
                                                                .foregroundColor: seletImageColor as Any]
        // 배지 스타일
        let badgeAttributes: [NSAttributedString.Key : Any] = [.foregroundColor: UIColor.named(.contentWhite), .font: ComponentFont.font(weight: .semibold, size: 8) as Any, .backgroundColor: UIColor.red as Any]


        let typographyNaviVC = BaseNavigationController(rootViewController: TypographyViewController())
        let colorPaletteNaviVC = BaseNavigationController(rootViewController: ColorPaletteViewController())
        
        typographyNaviVC.title = "타이포그라피".localization
        typographyNaviVC.tabBarItem.image = UIImage.getSFSymbolImage(name: "textformat.size", size: 18, weight: .regular, color: unSeletImageColor)
        typographyNaviVC.tabBarItem.selectedImage = UIImage.getSFSymbolImage(name: "textformat.size", size: 18, weight: .regular, color: seletImageColor)
        typographyNaviVC.tabBarItem.setTitleTextAttributes(attributes, for: .normal)
        typographyNaviVC.tabBarItem.setTitleTextAttributes(attributesSelect, for: .selected)
        typographyNaviVC.tabBarItem.setTitleTextAttributes(attributesSelect, for: .highlighted)
        typographyNaviVC.tabBarItem.setBadgeTextAttributes(badgeAttributes, for: .normal)
        typographyNaviVC.tabBarItem.setBadgeTextAttributes(badgeAttributes, for: .selected)

        colorPaletteNaviVC.title = "팔레트".localization
        colorPaletteNaviVC.tabBarItem.image = UIImage.getSFSymbolImage(name: "paintpalette", size: 18, weight: .regular, color: unSeletImageColor)
        colorPaletteNaviVC.tabBarItem.selectedImage = UIImage.getSFSymbolImage(name: "paintpalette", size: 18, weight: .regular, color: seletImageColor)
        colorPaletteNaviVC.tabBarItem.setTitleTextAttributes(attributes, for: .normal)
        colorPaletteNaviVC.tabBarItem.setTitleTextAttributes(attributesSelect, for: .selected)
        colorPaletteNaviVC.tabBarItem.setTitleTextAttributes(attributesSelect, for: .highlighted)
        colorPaletteNaviVC.tabBarItem.setBadgeTextAttributes(badgeAttributes, for: .normal)
        colorPaletteNaviVC.tabBarItem.setBadgeTextAttributes(badgeAttributes, for: .selected)

        let viewControllers = [typographyNaviVC, colorPaletteNaviVC]
        self.setViewControllers(viewControllers, animated: true)
#if DEVELOP
        self.tabBar.addSubview(lineView)
#endif
    }

    // 스크롤 탑 포지션
    private func setScrollTopPosition(views: [UIView]) {
        for view in views {
            if view.isKind(of: UITableView.self), let tableView = view as? UITableView {
                tableView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
                break
            } else if view.isKind(of: UIScrollView.self), let scrollView = view as? UIScrollView {
                scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
                break
            } else if view.isKind(of: UICollectionView.self), let collectionView = view as? UICollectionView {
                collectionView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
                break
            }
        }
    }
}

extension BaseTabBarController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if let naviVc = viewController as? UINavigationController, let _ = naviVc.viewControllers.last {
//            if viewVC.isKind(of: RegistrationViewController.self) {
//                selectedIndex = 0
//                let viewModel = RegistrationViewModel(draftId: nil, isSingup: false)
//                let registrationVC = RegistrationViewController(viewModel: viewModel)
//                (selectedViewController as? UINavigationController)?.pushViewController(registrationVC, animated: true)
//                return false
//            }
        }
        return true
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print("selected \(tabBarController.selectedIndex)")
        
        if let naviVc = viewController as? UINavigationController, let viewVC = naviVc.viewControllers.last {
//            if viewVC == preVC || (preVC == nil && viewVC.isKind(of: HomeViewController.self)) {
//               if viewVC.isKind(of: UIViewController.self) {
//                   setScrollTopPosition(views: viewVC.view.subviews)
//               }
//            }
            preVC = viewVC
        }
    }
}
