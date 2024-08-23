//
//  UINavigationBar+Extension.swift
//  iOSExample
//
//  Created by 10-N3344 on 2/15/24.
//

import UIKit

// https://stackoverflow.com/questions/30884170/how-can-i-set-the-uinavigationbar-with-gradient-color
class BaseGradientView: UIView {

    enum Point {
        case topRight, topLeft
        case bottomRight, bottomLeft
        case custom(point: CGPoint)

        var point: CGPoint {
            switch self {
                case .topRight: return CGPoint(x: 1, y: 0)
                case .topLeft: return CGPoint(x: 0, y: 0)
                case .bottomRight: return CGPoint(x: 1, y: 1)
                case .bottomLeft: return CGPoint(x: 0, y: 1)
                case .custom(let point): return point
            }
        }
    }

    private weak var gradientLayer: CAGradientLayer!

    convenience init(colors: [UIColor], startPoint: Point = .topLeft,
                     endPoint: Point = .bottomLeft, locations: [NSNumber] = [0, 1]) {
        self.init(frame: .zero)
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = frame
        layer.addSublayer(gradientLayer)
        self.gradientLayer = gradientLayer
        set(colors: colors, startPoint: startPoint, endPoint: endPoint, locations: locations)
        backgroundColor = .clear
    }

    func set(colors: [UIColor], startPoint: Point = .topLeft,
             endPoint: Point = .bottomLeft, locations: [NSNumber] = [0, 1]) {
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.startPoint = startPoint.point
        gradientLayer.endPoint = endPoint.point
        gradientLayer.locations = locations
    }

    func setupConstraints() {
        guard let parentView = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: parentView.topAnchor).isActive = true
        leftAnchor.constraint(equalTo: parentView.leftAnchor).isActive = true
        parentView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        parentView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        guard let gradientLayer = gradientLayer else { return }
        gradientLayer.frame = frame
        // superview?.addSubview(self)
        // self.sendSubviewToBack(self)
    }
}

extension UINavigationBar {
    func setGradientBackground(colors: [UIColor],
                               startPoint: BaseGradientView.Point = .topLeft,
                               endPoint: BaseGradientView.Point = .bottomLeft,
                               locations: [NSNumber] = [0, 1]) {
        guard let backgroundView = value(forKey: "backgroundView") as? UIView else { return }
        guard let gradientView = backgroundView.subviews.first(where: { $0 is BaseGradientView }) as? BaseGradientView else {
            let gradientView = BaseGradientView(colors: colors,
                                                startPoint: startPoint,
                                                endPoint: endPoint,
                                                locations: locations)
            backgroundView.addSubview(gradientView)
            gradientView.setupConstraints()
            return
        }
        gradientView.set(colors: colors, startPoint: startPoint, endPoint: endPoint, locations: locations)
    }

    func setNavigationBarStyle(_ backgroundColor: UIColor, fontColor foregroundColor: UIColor) {
        self.titleTextAttributes = [.foregroundColor: UIColor.white, .font: ComponentFont.sb18px.font]
        self.tintColor = foregroundColor
        self.isTranslucent = false
        self.backgroundColor = backgroundColor
        self.barTintColor = backgroundColor

        let scrollEdgeAppearance = UINavigationBarAppearance()
        scrollEdgeAppearance.configureWithOpaqueBackground()
        scrollEdgeAppearance.shadowColor = .clear
        scrollEdgeAppearance.shadowImage = UIImage()
        scrollEdgeAppearance.backgroundColor = backgroundColor
        scrollEdgeAppearance.largeTitleTextAttributes = [.foregroundColor : foregroundColor, .font : ComponentFont.b22px.font]
        scrollEdgeAppearance.titleTextAttributes = [.foregroundColor : foregroundColor, .font : ComponentFont.sb18px.font]
        self.standardAppearance = scrollEdgeAppearance
        self.scrollEdgeAppearance = scrollEdgeAppearance
    }

    func setDefaultNavigationBarStyle() {
        self.setNavigationBarStyle(UIColor.named(.mainColor), fontColor: UIColor.named(.contentWhite))
    }
}
