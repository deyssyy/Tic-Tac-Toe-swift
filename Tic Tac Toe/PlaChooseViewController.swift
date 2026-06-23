import UIKit

class PlaChooseViewController: UIViewController {
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
        button.setTitle("Один игрок", for: .normal)
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
        button.setTitle("Два игрока", for: .normal)
        button.setBackgroundImage(UIImage(resource: .menuHighlighted), for: .normal)
        button.layer.cornerRadius = 16
        button.clipsToBounds = true
        button.heightAnchor.constraint(equalToConstant: 52).isActive = true
        button.widthAnchor.constraint(equalToConstant: 186).isActive = true
        return button
    }()
    
    private let backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Назад", for: .normal)
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
    }
    
    private func setupUI(){
        view.addSubview(bgImageView)
        
        buttonsStackView.addArrangedSubview(newGameButton)
        buttonsStackView.addArrangedSubview(gameOptionsButton)
        buttonsStackView.addArrangedSubview(backButton)
        
        view.addSubview(buttonsStackView)
        
        NSLayoutConstraint.activate([
            bgImageView.topAnchor.constraint(equalTo: view.topAnchor),
            bgImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bgImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bgImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            buttonsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonsStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        newGameButton.addTarget(self, action: #selector(onePlayerTapped), for: .touchUpInside)
        gameOptionsButton.addTarget(self, action: #selector(twoPlayerTapped), for: .touchUpInside)
    }
    
    @objc private func backButtonTapped(){
        dismiss(animated: true)
    }
    
    @objc private func onePlayerTapped(){
        let vc = MainViewController()
        vc.incomeSegueID = "OnePlayer"
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        present(vc,animated: true)
    }
    
    @objc private func twoPlayerTapped(){
        let vc = MainViewController()
        vc.incomeSegueID = "TwoPlayer"
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        present(vc,animated: true)
    }
}
