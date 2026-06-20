import UIKit

class SettingsViewController: UIViewController {
    
    private let bgImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(resource: .BG)
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let headLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Настройки"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 32, weight: .regular)
        label.textColor = .black
        label.backgroundColor = UIColor(named: "settingsBG")
        label.heightAnchor.constraint(equalToConstant: 83).isActive = true
        label.widthAnchor.constraint(equalToConstant: 203).isActive = true
        return label
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
    
    private let difficultyPicker: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.backgroundColor = UIColor(named: "settingsBG")
        picker.heightAnchor.constraint(equalToConstant: 150).isActive = true
        picker.widthAnchor.constraint(equalToConstant: 240).isActive = true
        return picker
    }()
    
    private let pickerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Сложность"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 19, weight: .regular)
        label.textColor = .black
        return label
    }()
    
    private let pickerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = UIColor(named: "settingsBG")
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 10
        stackView.distribution = .fill
        stackView.widthAnchor.constraint(equalToConstant: 240).isActive = true
        return stackView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 100
        stackView.alignment = .center
        stackView.distribution = .fill
        return stackView
    }()
    
    let defaults = UserDefaults.standard
    let diffarr = ["Лёгкий","Нормальный","Сложный","Непобедимый"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        let temp = defaults.integer(forKey: "DifLevel")
        difficultyPicker.selectRow(temp, inComponent: 0, animated: true)
        }
    
    private func setupUI(){
        bgImageView.image = UIImage(resource: .BG)
        
        view.addSubview(bgImageView)
        
        pickerStackView.addArrangedSubview(pickerLabel)
        pickerStackView.addArrangedSubview(difficultyPicker)
        difficultyPicker.delegate = self
        difficultyPicker.dataSource = self
        
        stackView.addArrangedSubview(headLabel)
        stackView.addArrangedSubview(pickerStackView)
        
        view.addSubview(backButton)
        
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            bgImageView.topAnchor.constraint(equalTo: view.topAnchor),
            bgImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bgImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bgImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            backButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            
//            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 16),
//            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 16),
//            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -16),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            //stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: backButton.topAnchor, constant: -16)
        ])
    }
    
    @objc private func backButtonTapped(){
        dismiss(animated: true)
    }
}

extension SettingsViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return diffarr.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return diffarr[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        defaults.set(row, forKey: "DifLevel")
    }
    }


