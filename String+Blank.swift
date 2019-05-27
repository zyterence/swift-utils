extension String {
	var isBlank: Bool {
		return allSatisfy({ $0.isWhitespace })
	}
}

extension Optional where Wrapped == String {
	var isBlank: Bool {
		return self?.isBlank ?? true
	}
}

func test() {
	print("".isBlank)
	let title: String? = nil
	print(title.isBlank)
	print("   ".isBlank)
	print("hello".isBlank)
}
