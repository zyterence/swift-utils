typealias Task = (_ cancel: Bool) -> Void

@discardableResult
func delay(_ time: TimeInterval, task: @escaping()->()) -> Task? {
	
	func dispatch_later(block: @escaping ()->()) {
		let t = DispatchTime.now() + time
		DispatchQueue.main.asyncAfter(deadline: t, execute: block)
	}
	
	var closure: (()->Void)? = task
	var result: Task?
	
	let delayedClousure: Task = { cancel in
		if let internalClousure = closure {
			if (cancel == false) {
				DispatchQueue.main.async(execute: internalClousure)
			}
		}
		closure = nil
		result = nil
	}
	
	result = delayedClousure
	
	dispatch_later {
		if let delayedClousure = result {
			delayedClousure(false)
		}
	}
	
	return result
}

func cancel(_ task: Task?) {
	task?(true)
}
