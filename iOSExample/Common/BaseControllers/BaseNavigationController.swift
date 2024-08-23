//
//  BaseNavigationController.swift
//  iOSExample
//
//  Created by dongju.lim on 2023/02/13.
//

import UIKit

class BaseNavigationController: UINavigationController {
    
    // MARK: - Private Properties
    fileprivate var duringPushAnimation = false
    fileprivate let stopBackGestureViewControllers: [AnyClass] = []
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        delegate = self
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setNavigation()
        interactivePopGestureRecognizer?.delegate = self
        delegate = self
    }
    
    private func setNavigation(){
        self.navigationBar.setDefaultNavigationBarStyle()
    }

    deinit {
        delegate = nil
        interactivePopGestureRecognizer?.delegate = nil
    }

}

// MARK: - UINavigationControllerDelegate
extension BaseNavigationController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let navigation = navigationController as? BaseNavigationController else { return }
        navigation.duringPushAnimation = false
    }
}

// MARK: - UIGestureRecognizerDelegate
extension BaseNavigationController: UIGestureRecognizerDelegate {
    // 제스쳐 동작으로 뒤로가기를 막을때
    private func gestureMoveCheck(viewVC: UIViewController) -> Bool {
        if (stopBackGestureViewControllers.filter({ viewVC.isKind(of: $0)}).first != nil) {
//            if let detailVC = viewVC as? RegistrationDetailViewController {
//                if detailVC.viewModel.viewType == .confirmView {
//                    return false
//                } else {
//                    // 매물 상세 보기는 뒤로가기 허용
//                    return true
//                }
//            }
            return false
        }
        return true
    }

    // 뒤로 가기 이동시 기능 처리가 필요할때
    private func backActionCheck(viewVC: UIViewController) -> Bool {
//        if let regVC = viewVC as? RegistrationViewController {
//            regVC.onBackView()
//            return false
//        }
        return true
    }

    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard gestureRecognizer == interactivePopGestureRecognizer, let currentVC = topViewController else {
            return true // default value
        }

        if gestureMoveCheck(viewVC: currentVC) == false || backActionCheck(viewVC: currentVC) == false {
            return false
        }

        // Disable pop gesture in two situations:
        // 1) when the pop animation is in progress
        // 2) when user swipes quickly a couple of times and animations don't have time to be performed
        return (viewControllers.count > 1 && (duringPushAnimation == false))
    }

    /*
     UIScrollView에서 좌우 Swipe시 제스처 이벤트가 UIScrollView에 종속되어 interactivePopGestureRecognizer 이벤트를 처리를 하지 못한다.
     shouldRecognizeSimultaneouslyWith 메소드는 UINavigationController UIGestureRecognizerDelegate 및 UIScrollView 제스쳐 둘다 허용하려면 return true를 하면됨
     shouldRecognizeSimultaneouslyWith 메소드는 스크롤을 움직일때 마다 이벤트가 올라옴
     */
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                           shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        guard gestureRecognizer == interactivePopGestureRecognizer else { return false }
        return true
    }

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                           shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }
}

