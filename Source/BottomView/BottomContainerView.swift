import UIKit

protocol BottomContainerViewDelegate: class {

    func pickerButtonDidPress()
    func doneButtonDidPress()
    func flashButtonDidPress(_ title: String)
    func rotateDeviceDidPress()
    
}

open class BottomContainerView: UIView {
    
    struct Dimensions {
        static let height: CGFloat = 101
        static let buttonSize: CGFloat = 28
    }
    
    var currentFlashIndex = 0
    let flashButtonTitles = ["AUTO", "ON", "OFF"]
    
    var configuration = Configuration()
    
    lazy var pickerButton: ButtonPicker = { [unowned self] in
        let pickerButton = ButtonPicker()
        pickerButton.setTitleColor(UIColor.white, for: UIControlState())
        pickerButton.delegate = self
        pickerButton.numberLabel.isHidden = !self.configuration.showsImageCountLabel
        
        return pickerButton
        }()
    
    lazy var borderPickerButton: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = ButtonPicker.Dimensions.borderWidth
        view.layer.cornerRadius = ButtonPicker.Dimensions.buttonBorderSize / 2
        
        return view
    }()
    
    
    lazy var topSeparator: UIView = { [unowned self] in
        let view = UIView()
        view.backgroundColor = self.configuration.backgroundColor
        
        return view
        }()
    
    lazy var flashButton: UIButton = { [unowned self] in
        let button = UIButton()
        button.setImage(AssetManager.getImage("AUTO"), for: UIControlState())
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.withAlphaComponent(0.4).cgColor
        button.layer.cornerRadius = Dimensions.buttonSize / 2
        button.setTitleColor(UIColor.white, for: UIControlState())
        button.setTitleColor(UIColor.white, for: .highlighted)
        button.titleLabel?.font = self.configuration.flashButton
        button.addTarget(self, action: #selector(flashButtonDidPress(_:)), for: .touchUpInside)
        button.contentHorizontalAlignment = .center
        
        return button
        }()
    
    lazy var rotateCamera: UIButton = { [unowned self] in
        let button = UIButton()
        button.setImage(AssetManager.getImage("cameraicon"), for: UIControlState())
        button.addTarget(self, action: #selector(rotateCameraButtonDidPress(_:)), for: .touchUpInside)
        button.imageView?.contentMode = .center
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.withAlphaComponent(0.4).cgColor
        button.layer.cornerRadius = Dimensions.buttonSize / 2
        
        return button
        }()
    
    
    weak var delegate: BottomContainerViewDelegate?
    var pastCount = 0
    
    // MARK: Initializers
    
    public init(configuration: Configuration? = nil) {
        if let configuration = configuration {
            self.configuration = configuration
        }
        super.init(frame: .zero)
        configure()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        [borderPickerButton, pickerButton, topSeparator, flashButton, rotateCamera].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        backgroundColor = configuration.backgroundColor
        
        setupConstraints()
    }
    
    // MARK: - Action methods
    
    func flashButtonDidPress(_ button: UIButton) {
        currentFlashIndex += 1
        currentFlashIndex = currentFlashIndex % flashButtonTitles.count
        
        switch currentFlashIndex {
        case 1:
            button.setTitleColor(UIColor(red: 0.98, green: 0.98, blue: 0.45, alpha: 1), for: UIControlState())
            button.setTitleColor(UIColor(red: 0.52, green: 0.52, blue: 0.24, alpha: 1), for: .highlighted)
        default:
            button.setTitleColor(UIColor.white, for: UIControlState())
            button.setTitleColor(UIColor.white, for: .highlighted)
        }
        
        let newTitle = flashButtonTitles[currentFlashIndex]
        
        button.setImage(AssetManager.getImage(newTitle), for: UIControlState())
//        button.setTitle(newTitle, for: UIControlState())
        
        delegate?.flashButtonDidPress(newTitle)
    }
    
    func rotateCameraButtonDidPress(_ button: UIButton) {
        delegate?.rotateDeviceDidPress()
    }
    
}

// MARK: - ButtonPickerDelegate methods

extension BottomContainerView: ButtonPickerDelegate {

  func buttonDidPress() {
    delegate?.pickerButtonDidPress()
  }
}
