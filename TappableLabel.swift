import UIKit

class TappableLabel: UILabel {
	
	typealias Round = (corners: UIRectCorner?, radius: CGFloat?)
	
	private var tapped: (() -> ())?
	
	private var round: Round
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		active()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		active()
	}
	
	convenience init(round: Round = (nil, nil)) {
		self.init(frame: .zero)
		self.round = round
	}
	
	private func active() {
		self.isUserInteractionEnabled = true
		let tapGesture = UITapGestureRecognizer()
		tapGesture.numberOfTouchesRequired = 1
		tapGesture.numberOfTapsRequired = 1
		tapGesture.addTarget(self, action: #selector(tapAction))
		self.addGestureRecognizer(tapGesture)
	}
	
	func whenTapped(_ action:@escaping () -> ())  {
		tapped = action
	}
	
	@objc private func tapAction() {
		if let action = tapped {
			action()
		}
	}
}

extension TappableLabel: RoundCorners {

	override func layoutSubviews() {
		super.layoutSubviews()
		if let corners = round.corners, let radius = round.radius {
			roundCorners(corners: corners, radius: radius)
		}
	}
}

protocol RoundCorners {
	func roundCorners(corners: UIRectCorner, radius: CGFloat)
}

extension RoundCorners where Self: UIView {
	
	func roundCorners(corners: UIRectCorner, radius: CGFloat) {
		let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
		let mask = CAShapeLayer()
		mask.path = path.cgPath
		layer.mask = mask
	}
}