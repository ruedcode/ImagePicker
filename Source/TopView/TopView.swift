import UIKit

protocol TopViewDelegate: class {
    func cancelButtonDidPress()
}

class TopView: UIView {

    struct Dimensions {
        static let leftOffset: CGFloat = 10
        static let rightOffset: CGFloat = 7
        static let height: CGFloat = 42
    }

    var configuration = Configuration()
    
    lazy var cancelButton: UIButton = { [unowned self] in
        let button = UIButton()
        button.setTitle(self.configuration.cancelButtonTitle, for: UIControlState())
        button.setTitleColor(UIColor.white, for: UIControlState())
        button.setTitleColor(UIColor.white, for: .highlighted)
        button.titleLabel?.font = self.configuration.doneButton
        button.addTarget(self, action: #selector(cancelButtonDidPress(_:)), for: .touchUpInside)
        return button

    }()
    
    lazy var titleLabel: UILabel = { [unowned self] in
        let label = UILabel()
        label.text = self.configuration.imagePickerTitle
        label.textColor = UIColor.white
        label.font = self.configuration.titleFont
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    

    weak var delegate: TopViewDelegate?

  // MARK: - Initializers

    public init(configuration: Configuration? = nil) {
        if let configuration = configuration {
            self.configuration = configuration
        }
        super.init(frame: .zero)
        configure()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }


    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure() {
        let buttons: [UIButton] = [cancelButton]

//    if configuration.canRotateCamera {
//      buttons.append(rotateCamera)
//    }

        for button in buttons {
            button.layer.shadowColor = UIColor.black.cgColor
            button.layer.shadowOpacity = 0.5
            button.layer.shadowOffset = CGSize(width: 0, height: 1)
            button.layer.shadowRadius = 1
            button.translatesAutoresizingMaskIntoConstraints = false
            addSubview(button)
        }
        addSubview(titleLabel)

        setupConstraints()
    }

    // MARK: - Action methods
    
    func cancelButtonDidPress(_ button: UIButton) {
        delegate?.cancelButtonDidPress()
    }

}
