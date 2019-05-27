import UIKit

class GradientView: UIView {
	
	let gradientLayer = CAGradientLayer()
	var colors: [Any]?
	var locations: [NSNumber]?
	
	override init(frame: CGRect) {
		super.init(frame: frame)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	public convenience init(colors: [Any]?, locations: [NSNumber]?) {
		self.init(frame: .zero)
		self.colors = colors
		self.locations = locations
		setup()
	}
	
	func setup() {
		translatesAutoresizingMaskIntoConstraints = false
		backgroundColor = .clear
		clipsToBounds = true
		
		gradientLayer.colors = colors
		gradientLayer.locations = locations
		layer.addSublayer(gradientLayer)
	}
	
	override func layoutSubviews() {
		gradientLayer.frame = self.bounds
	}
}
