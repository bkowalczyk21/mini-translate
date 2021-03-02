import UIKit

class TranslationViewController: UIViewController {

    @IBOutlet weak var mainStackView: UIStackView!
    var spanishButton: UIButton!
    var frenchButton: UIButton!
    var englishButton: UIButton!
    var toSpanishButton: UIButton!
    var toFrenchButton: UIButton!
    var toEnglishButton: UIButton!
    var translateButton: UIButton!
    var language: Language!
    var outputLanguage: Language!
    var resultLabel: UILabel!
    var inputTextField: UITextField!
    
    enum Language {
        case french
        case spanish
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        spanishButton = UIButton.create(title: "From Spanish")
        frenchButton = UIButton.create(title: "From French")
        englishButton = UIButton.create(title: "From English")
        toSpanishButton = UIButton.create(title: "To Spanish")
        toFrenchButton = UIButton.create(title: "To French")
        toEnglishButton = UIButton.create(title: "To English")
        translateButton = UIButton.create(title: "Choose Language To Translate To")
        resultLabel = UILabel.create(title: "Translation Result")
        inputTextField = UITextField.create(placeholder: "Enter Text To Translate")
        
        //inputTextField.addTarget(self, action: #selector(didUpdateTextField), for: .allEditingEvents)
        
        translateButton.addTarget(self, action: #selector(didPressTranslate), for: .touchUpInside)
        
        spanishButton.addTarget(self, action: #selector(didPressSpanish), for: .touchUpInside)
        frenchButton.addTarget(self, action: #selector(didPressFrench), for: .touchUpInside)
        
        self.mainStackView.addArrangedSubviews([
            UIStackView.create(arrangedSubviews: [
                self.inputTextField,
                self.frenchButton,
                self.spanishButton,
            ]),
            
            UIStackView.create(arrangedSubviews: [
                self.translateButton,
                self.resultLabel
            ])
        ])
    }
    
    @objc func didPressTranslate() {
        if let input = inputTextField.text?.lowercased() {
            if let lang = language {
                switch lang {
                case .french:
                    if Translations.englishWords.contains(input) {
                        if let index = Translations.englishWords.firstIndex(of: input) {
                            let output = Translations.frenchWords[index]
                            resultLabel.text = output
                        }
                    } else {
                        resultLabel.text = "Word is not in our library :("
                    }
                case .spanish:
                    if Translations.englishWords.contains(input) {
                        if let index = Translations.englishWords.firstIndex(of: input) {
                            let output = Translations.spanishWords[index]
                            resultLabel.text = output
                        }
                    } else {
                        resultLabel.text = "Word is not in our library :("
                    }
                default:
                    print("Language selected not recognized")
                }
            }
        }
        
    }
    
    @objc func didPressSpanish() {
        spanishButton.setTitle(">Spanish", for: .normal)
        frenchButton.setTitle("French", for: .normal)
        translateButton.setTitle("Translate To Spanish", for: .normal)
        language = .spanish
    }
    
    @objc func didPressFrench() {
        spanishButton.setTitle("Spanish", for: .normal)
        frenchButton.setTitle(">French", for: .normal)
        translateButton.setTitle("Translate To French", for: .normal)
        language = .french
    }
    

}


// MARK: - UIKit Extensions

extension UIButton {
    static func create(title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.backgroundColor = .secondarySystemFill
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        return button
    }
}

extension UIStackView {
    static func create(arrangedSubviews: [UIView]) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.addArrangedSubviews(arrangedSubviews)
        return stackView
    }

    func addArrangedSubviews(_ arrangedSubviews: [UIView]) -> Void {
        arrangedSubviews.forEach { self.addArrangedSubview($0) }
    }
}

extension UILabel {
    static func create(title: String) -> UILabel {
        let label = UILabel()
        label.text = title
        label.textColor = .secondaryLabel
        return label
    }
}

extension UITextField {
    static func create(placeholder: String) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.borderStyle = .roundedRect
        return textField
    }
}
