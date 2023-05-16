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
    
    var lineView = UIView().then {
        $0.backgroundColor = .lightText
    }
    
    override func loadView() {
        super.loadView()
        setTapBarViewControllers()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

extension BaseTabBarController {
    
    private func setTapBarViewControllers() {
//        let homeVC = HomeViewController(viewModel: HomeViewModel())
//        let homeNavigationVC = BaseNavigationController(rootViewController: homeVC)
//
//        let viewModel = RegistrationViewModel(draftId: nil, isSingup: false)
//        let tmpVC = RegistrationViewController(viewModel: viewModel)
//        let tmpNvVC = BaseNavigationController(rootViewController: tmpVC)
//
//        let myPageVC = MyPageViewController()
//        let myPageNVVC = BaseNavigationController(rootViewController: myPageVC)
//
//        let viewControllers = [homeNavigationVC, tmpNvVC, myPageNVVC]
//        self.setViewControllers(viewControllers, animated: true)
    }
    
    private func setupUI(){
        delegate = self
        view.backgroundColor = .white
        
//        let itemImages: [UIImage] = [VImage.ic_home()!, VImage.ic_reg()!, VImage.ic_mypage()!]
//        let titles = [VText.tabbar_home(), VText.tabbar_reg(), VText.tabbar_mypage()]
//
//        let unSeletImageColor = UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 1.0)
//        let attributes: [NSAttributedString.Key : Any] = [.font: VFont.pretendardSemiBold(size: 10) as Any,
//                                                          .foregroundColor: VColor.vTextGray05() as Any]
//
//        let attributesSelect: [NSAttributedString.Key : Any] = [.font: VFont.pretendardSemiBold(size: 10) as Any,
//                                                                .foregroundColor: VColor.vPrimaryPurple1() as Any]
//        let tabbarItems = self.tabBar.items
//        for (index, item) in (tabbarItems?.enumerated())! {
//            item.image = itemImages[index].withTintColor(unSeletImageColor)
//            item.selectedImage = itemImages[index].withTintColor(VColor.vPrimaryPurple1()!)
//            item.title = titles[index]
//
//
//            item.setTitleTextAttributes(attributes, for: .normal)
//            item.setTitleTextAttributes(attributesSelect, for: .selected)
//            item.setTitleTextAttributes(attributesSelect, for: .highlighted)
//        }
//
//        let tabBar: UITabBar = self.tabBar
//        tabBar.backgroundColor = UIColor.white
//        tabBar.barTintColor = UIColor.white
//        ///선택되었을 때 타이틀 컬러
//        tabBar.tintColor = VColor.vPrimaryPurple1()
//        ///선택안된거 타이틀 컬러
//        tabBar.unselectedItemTintColor = VColor.vTextGray05()
//        tabBar.isHidden = false
//        tabBar.isTranslucent = false
        
        tabBar.addSubview(lineView)
        lineView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(1)
        }
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
