////
////  inputTextView.swift
////  Mini Challenge 1 Team 4
////
////  Created by Catharina Adinda Mega Cahyani on 08/04/22.
////
//
//import UIKit
//
////class inputTextView: UITextView {
////
////    /*
////    // Only override draw() if you perform custom drawing.
////    // An empty implementation adversely affects performance during animation.
////    override func draw(_ rect: CGRect) {
////        // Drawing code
////    }
////    */
////
////}
//
//
//open class inputTextView: UITextView {
//
//    /// Контейнер с дополнительными лейблами.
//    private let textBox = UITextView()
//
//    var notificationCenter: NotificationCenter { return .default }
//
//    // MARK: - Init
//    public override init(frame: CGRect, textContainer: NSTextContainer?) {
//        super.init(frame: frame, textContainer: textContainer)
//        commonInit()
//    }
//
//    public required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        commonInit()
//    }
//
//    deinit {
//        notificationCenter.removeObserver(self)
//    }
//
//    /// Первичная настройка после `init`.
//    open func commonInit() {
//        textContainer.lineFragmentPadding = 0
//        addSubview(textBox)
//        observerNotifications()
//        updateState(animated: false)
//    }
//
//    // MARK: - UITextView
//    open override var text: String! {
//        didSet { updateState(animated: false) }
//    }
//
//    // MARK: - UIView
//    open override func layoutSubviews() {
//        super.layoutSubviews()
//        textBox.frame = bounds
//        textContainerInset = textBox.editingTextInsets
//    }
//
//    // MARK: - Private
//    /// Начать наблюдение за уведомлениями.
//    private func observerNotifications() {
//        observe(UITextView.textDidBeginEditingNotification, #selector(textDidEditing))
//        observe(UITextView.textDidChangeNotification, #selector(textDidEditing))
//        observe(UITextView.textDidEndEditingNotification, #selector(textDidEditing))
//    }
//
//    private func observe(_ name: NSNotification.Name, _ selector: Selector) {
//        notificationCenter.addObserver(self, selector: selector, name: name, object: self)
//    }
//
//    @objc private func textDidEditing() {
//        updateState(animated: true)
//    }
//
////    private func updateState(animated: Bool) {
////        let state = TextInputState(hasText: hasText, firstResponder: isFirstResponder)
////        textBox.setState(state, animated: animated)
////    }
//}
