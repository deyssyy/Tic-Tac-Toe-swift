import UIKit

class MenuViewController: UIViewController {

    private let bgImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(resource: .BG)
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let newGameButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Новая Игра", for: .normal)
        button.setBackgroundImage(UIImage(resource: .menuHighlighted), for: .normal)
        button.layer.cornerRadius = 16
        button.clipsToBounds = true
        button.heightAnchor.constraint(equalToConstant: 52).isActive = true
        button.widthAnchor.constraint(equalToConstant: 186).isActive = true
        return button
    }()
    
    private let gameOptionsButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Настройки", for: .normal)
        button.setBackgroundImage(UIImage(resource: .menuHighlighted), for: .normal)
        button.layer.cornerRadius = 16
        button.clipsToBounds = true
        button.heightAnchor.constraint(equalToConstant: 52).isActive = true
        button.widthAnchor.constraint(equalToConstant: 186).isActive = true
        return button
    }()
    
    private let buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fill
        return stackView
    }()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
       // if UserDefaults.standard.integer(forKey: "DifLevel") == nil{
       //     UserDefaults.standard.setValue("0", forKey: "DifLevel")
       // }
    }
    
    private func setupUI(){
        view.addSubview(bgImageView)
        
        buttonsStackView.addArrangedSubview(newGameButton)
        buttonsStackView.addArrangedSubview(gameOptionsButton)
        
        view.addSubview(buttonsStackView)
        
        NSLayoutConstraint.activate([
            bgImageView.topAnchor.constraint(equalTo: view.topAnchor),
            bgImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bgImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bgImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            buttonsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonsStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        gameOptionsButton.addTarget(self, action: #selector(gameOptionsButtonTapped), for: .touchUpInside)
        newGameButton.addTarget(self, action: #selector(newGameButtonTapped), for: .touchUpInside)
    }
    
    @objc private func newGameButtonTapped(){
        let newVC = PlaChooseViewController()
        present(newVC,animated: true)
    }

    @objc private func gameOptionsButtonTapped(){
        let newVC = SettingsViewController()
        present(newVC, animated: true)
    }
}
