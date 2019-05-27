import UIKit

class TappableView: UIView {
	private var tapped: (() -> ())?
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		active()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		active()
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
