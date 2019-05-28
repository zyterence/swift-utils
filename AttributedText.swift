public class AttributedText {
	public class Attributer {
		fileprivate var attributes: [NSAttributedString.Key : Any]
		
		init() {
			attributes = [NSAttributedString.Key : Any]()
		}
		
		public func set(font: UIFont) {
			attributes[NSAttributedString.Key.font] = font
		}
		
		public func setFont(name: String, size: CGFloat) {
			attributes[NSAttributedString.Key.font] = UIFont(name: name, size: size) ?? UIFont.systemFont(ofSize: size)
		}
		
		public func set(color: UIColor) {
			attributes[NSAttributedString.Key.foregroundColor] = color
		}
		
		public func set(offset: CGFloat) {
			attributes[NSAttributedString.Key.baselineOffset] = offset
		}
		
		public func setUnderline(style: NSUnderlineStyle, color: UIColor) {
			attributes[NSAttributedString.Key.underlineStyle] = style.rawValue
			attributes[NSAttributedString.Key.underlineColor] = color
		}
		
		public func setStrikethrough(style: NSUnderlineStyle, color: UIColor) {
			attributes[NSAttributedString.Key.strikethroughStyle] = style.rawValue
			attributes[NSAttributedString.Key.strikethroughColor] = color
		}
	}
	
	public var text: NSMutableAttributedString
	
	init() {
		text = NSMutableAttributedString(string: "", attributes: nil)
	}
	
	@discardableResult
	func append(_ text:String, attribute: ((Attributer)->())? = nil) -> NSMutableAttributedString {
		let attributer = Attributer()
		attribute?(attributer)
		let new = NSMutableAttributedString(string: text, attributes: attributer.attributes)
		self.text.append(new)
		return new
	}
}
