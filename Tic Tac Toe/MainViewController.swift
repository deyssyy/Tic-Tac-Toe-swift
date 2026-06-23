////
////  ViewController.swift
////  Tic Tac Toe
////
////  Created by nikita on 12.11.2023.
////
//
//import UIKit
//
//class MainViewController: UIViewController {
//    
//    @IBOutlet weak var DifLabel: UILabel!
//    @IBOutlet weak var button0: UIButton!
//    @IBOutlet weak var button1: UIButton!
//    @IBOutlet weak var button2: UIButton!
//    @IBOutlet weak var button3: UIButton!
//    @IBOutlet weak var button4: UIButton!
//    @IBOutlet weak var button5: UIButton!
//    @IBOutlet weak var button6: UIButton!
//    @IBOutlet weak var button7: UIButton!
//    @IBOutlet weak var button8: UIButton!
//    @IBOutlet weak var TurnImage: UIImageView!
//    @IBOutlet weak var TurnLabel: UILabel!
//    
//    @IBOutlet var buttons: [UIButton]!
//    
//    @IBOutlet var images: [UIImageView]!
//    
//    private let bgImageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.contentMode = .scaleAspectFill
//        imageView.image = UIImage(resource: .BG)
//        imageView.clipsToBounds = true
//        return imageView
//    }()
//    
//    private let difficultyLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = "Сложность: "
//        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
//        label.textColor = .black
//        return label
//    }()
//    
//    private let turnLabel: UILabel = {
//        let label = UILabel()
//        label.text = "Ход:"
//        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//    
//    private let turnImage: UIImageView = {
//        let imageView = UIImageView()
//        imageView.contentMode = .scaleAspectFit
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        return imageView
//    }()
//    
//    private let menuButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setImage(UIImage(resource: .icons8Settings100), for: .normal)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//    }()
//    
//    var WinningSet : Set<Set<Int>> = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
//    var board = [0,0,0,0,0,0,0,0,0]
//    
//    var diffarr = ["Лёгкий","Нормальный","Сложный","Непобедимый"]
//    let dif = UserDefaults.standard.integer(forKey: "DifLevel")
//    var IncomeSegueID = ""
//    var playerX = Player()
//    var playerO = Player()
//    var computer = false
//    var turn = "X"
//    @IBAction func abbba(_ sender: Any) {
//        Alert(title: "ggg", message: "asa", style: .alert)
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        DifLabel.text = "Сложность: \(diffarr[dif])"
//        TurnImage.image = UIImage(named: "icons8-x-100")
//        if IncomeSegueID == "OnePlayer"{
//            TurnImage.isHidden = true
//            TurnLabel.isHidden = true
//            computer = true
//        }else{
//            DifLabel.isHidden = true
//        }
//        ResetGame()
//    }
//    
//    @IBAction func MenuButtonTapped(_ sender: UIButton) {
//        dismiss(animated: true)
//    }
//    
//    @IBAction func FiledButtonPressed(_ sender: UIButton) {
//        if computer{
//            playerX.MakeMove(cell: sender.tag){board[sender.tag] = 1}
//            images[sender.tag].image = UIImage(named: "icons8-x-100")
//            sender.isEnabled = false
//            for elem in buttons{
//                elem.isUserInteractionEnabled = false
//            }
//            if wincondition(player: playerX.move){
//                Alert(title: "Победа игрока!", message: "Хотели бы вы начать заново?", style: .alert)
//            }else if CheckDraw(){
//                Alert(title: "Ничья", message: "Хотели бы вы начать заново?", style: .alert)
//            }
//            
//            else{
//                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
//                    let movePC = self.pcMove(board: self.board, player: self.playerX.move, PC: self.playerO.move)
//                    self.playerO.MakeMove(cell: movePC){self.board[movePC] = 2}
//                    self.images[movePC].image = UIImage(named: "icons8-o-100")
//                    self.buttons[movePC].isEnabled = false
//                    if self.wincondition(player: self.playerO.move){
//                        self.Alert(title: "Победа компьютера!", message: "Хотели бы вы начать заново?", style: .alert)
//                    }
//                    for elem in self.buttons{
//                        elem.isUserInteractionEnabled = true
//                    }
//                }
//            }
//        }else{
//            if turn == "X"{
//                turn = "O"
//                playerX.MakeMove(cell: sender.tag){board[sender.tag] = 1}
//                images[sender.tag].image = UIImage(named: "icons8-x-100")
//                sender.isEnabled = false
//                if wincondition(player: playerX.move){
//                    Alert(title: "Победа игрока X!", message: "Хотели бы вы начать заново?", style: .alert)
//                }else if CheckDraw(){
//                    Alert(title: "Ничья", message: "Хотели бы вы начать заново?", style: .alert)
//                }
//                TurnImage.image = UIImage(named: "icons8-o-100")
//            }else{
//                turn = "X"
//                playerO.MakeMove(cell: sender.tag){board[sender.tag] = 2}
//                images[sender.tag].image = UIImage(named: "icons8-o-100")
//                sender.isEnabled = false
//                if wincondition(player: playerO.move){
//                    Alert(title: "Победа игрока O!", message: "Хотели бы вы начать заново?", style: .alert)
//                }
//                TurnImage.image = UIImage(named: "icons8-x-100")
//            }
//        }
//        
//        
//    }
//    
//    private func pcMove(board: [Int], player: [Int?], PC: [Int?]) -> Int {
//        let WinningSet : Set<Set<Int>> = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
//        var move: Int
//        
//        switch dif{
//        case 1:
//            if CenterMove() != nil {
//                move = CenterMove()!
//                return move
//            }else{
//                return RandomMove()
//            }
//        case 2:
//            if AbusePlayer(player: player) != nil{
//                move = AbusePlayer(player: player)!
//                return move
//            }else if CenterMove() != nil {
//                move = CenterMove()!
//                return move
//            }else{
//                return RandomMove()
//            }
//        case 3:
//            if WinningMove(PC: PC) != nil{
//                move = WinningMove(PC: PC)!
//                return move
//            }else if AbusePlayer(player: player) != nil{
//                move = AbusePlayer(player: player)!
//                return move
//            }else if CenterMove() != nil {
//                move = CenterMove()!
//                return move
//            }else{
//                return RandomMove()
//            }
//        default:
//            return RandomMove()
//        }
//    }
//    
//    private func RandomMove() -> Int{
//        var move = Int.random(in: 0...8)
//        while board[move] != 0{
//            move = Int.random(in: 0...8)
//        }
//        return move
//    }
//    
//    private func CenterMove() -> Int?{
//        if board[4] == 0{
//            return 4
//        }
//        return nil
//    }
//    
//    private func WinningMove(PC: [Int?]) -> Int?{
//        let movePC = Set(PC.compactMap{$0})
//        for elem in WinningSet{
//            let pos = elem.subtracting(movePC)
//            if pos.count == 1 && board[pos.first!] == 0{
//                return pos.first!
//            }
//        }
//        return nil
//    }
//    
//    private func AbusePlayer(player: [Int?]) -> Int?{
//        let moveplayer = Set(player.compactMap{$0})
//        for elem in WinningSet{
//            let pos = elem.subtracting(moveplayer)
//            if pos.count == 1 && board[pos.first!] == 0{
//                return pos.first!
//            }
//        }
//        return nil
//    }
//    
//    private func CheckDraw() -> Bool {
//        let newboard = board.filter{$0 == 0}
//        if newboard.isEmpty{
//            return true
//        }
//        return false
//    }
//    
//    private func wincondition(player: [Int?]) -> Bool{
//        let move = Set(player.compactMap{$0})
//        for elem in WinningSet{
//            if elem.isSubset(of: move){
//                return true
//            }
//        }
//        return false
//    }
//    
//    private func ResetGame(){
//        for i in 0...8{
//            images[i].image = nil
//            buttons[i].isEnabled = true
//            buttons[i].isUserInteractionEnabled = true
//        }
//        turn = "X"
//        TurnImage.image = UIImage(named: "icons8-x-100")
//        board = Array(repeating: 0, count: 9)
//        playerX.move = Array(repeating: nil, count: 9)
//        playerO.move = Array(repeating: nil, count: 9)
//    }
//    
//    private func DrawBoard(){
//        for elem in board{
//            if elem == 1{
//                images[elem].image = UIImage(named: "icons8-x-100")
//            }else if elem == 2{
//                images[elem].image = UIImage(named: "icons8-o-100")
//            }
//        }
//    }
//    
//    private func Alert(title: String, message: String, style: UIAlertController.Style)
//    {
//        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
//        let alertactionYes = UIAlertAction(title: "Да", style: .default){_ in
//            self.ResetGame()
//        }
//        let alertactionNo = UIAlertAction(title: "Нет", style: .default){_ in
//            self.dismiss(animated: true)
//        }
//        alert.addAction(alertactionYes)
//        alert.addAction(alertactionNo)
//        self.present(alert, animated: true)
//    }
//}
//
//
//  ViewController.swift
//  Tic Tac Toe
//
//  Created by nikita on 12.11.2023.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - UI Elements
    private let bgImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(resource: .BG)
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let difLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.backgroundColor = .white.withAlphaComponent(0.7)
        label.clipsToBounds = true
        label.layer.cornerRadius = 8
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let turnLabel: UILabel = {
        let label = UILabel()
        label.text = "Ход:"
        label.font = UIFont.systemFont(ofSize: 25, weight: .medium)
        label.backgroundColor = .white.withAlphaComponent(0.7)
        label.clipsToBounds = true
        label.layer.cornerRadius = 8
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let turnImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.backgroundColor = .white.withAlphaComponent(0.7)
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 8
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let menuButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(resource: .icons8Settings100), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        button.backgroundColor = .white.withAlphaComponent(0.7)
        button.clipsToBounds = true
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var boardButtons: [UIButton] = []
    
    // MARK: - Game Logic Variables
    private let winningSet: Set<Set<Int>> = [
        [0,1,2], [3,4,5], [6,7,8],
        [0,3,6], [1,4,7], [2,5,8],
        [0,4,8], [2,4,6]
    ]
    private var board = Array(repeating: 0, count: 9)
    
    private let diffarr = ["Лёгкий", "Нормальный", "Сложный", "Непобедимый"]
    private var dif: Int { UserDefaults.standard.integer(forKey: "DifLevel") }
    
    var incomeSegueID = ""
    
    private var playerX = Player()
    private var playerO = Player()
    private var computer = false
    private var turn = "X"
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupUI()
        
        if dif >= 0 && dif < diffarr.count {
            difLabel.text = "Сложность: \(diffarr[dif])"
        } else {
            difLabel.text = "Сложность: Неизвестно"
        }
        
        turnImage.image = UIImage(named: "icons8-x-100")
        
        if incomeSegueID == "OnePlayer" {
            turnImage.isHidden = true
            turnLabel.isHidden = true
            computer = true
        } else {
            difLabel.isHidden = true
        }
        
        resetGame()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        view.addSubview(bgImageView)
        view.addSubview(difLabel)
        view.addSubview(turnLabel)
        view.addSubview(turnImage)
        view.addSubview(menuButton)
        
        let boardStackView = UIStackView()
        boardStackView.axis = .vertical
        boardStackView.spacing = 10
        boardStackView.distribution = .fillEqually
        boardStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(boardStackView)
        
        for _ in 0..<3 {
            let rowStack = UIStackView()
            rowStack.axis = .horizontal
            rowStack.spacing = 10
            rowStack.distribution = .fillEqually
            
            for _ in 0..<3 {
                let index = boardButtons.count
                let button = UIButton()
                button.tag = index
                button.backgroundColor = .systemGray5
                button.layer.borderWidth = 1
                button.layer.cornerRadius = 8
                button.translatesAutoresizingMaskIntoConstraints = false
                button.heightAnchor.constraint(equalTo: button.widthAnchor).isActive = true
                button.addTarget(self, action: #selector(fieldButtonPressed(_:)), for: .touchUpInside)
                
                boardButtons.append(button)
                rowStack.addArrangedSubview(button)
            }
            boardStackView.addArrangedSubview(rowStack)
        }
        
        menuButton.addTarget(self, action: #selector(menuButtonTapped(_:)), for: .touchUpInside)
        setupConstraints(boardStackView: boardStackView)
    }
    
    private func setupConstraints(boardStackView: UIStackView) {
        NSLayoutConstraint.activate([
            bgImageView.topAnchor.constraint(equalTo: view.topAnchor),
            bgImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bgImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bgImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            difLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            difLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            turnLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            turnLabel.trailingAnchor.constraint(equalTo: turnImage.leadingAnchor, constant: -10),
            
            turnImage.centerYAnchor.constraint(equalTo: turnLabel.centerYAnchor),
            turnImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            turnImage.widthAnchor.constraint(equalToConstant: 50),
            turnImage.heightAnchor.constraint(equalToConstant: 50),
            
            menuButton.topAnchor.constraint(equalTo: difLabel.bottomAnchor, constant: 20),
            menuButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            boardStackView.topAnchor.constraint(equalTo: menuButton.bottomAnchor, constant: 40),
            boardStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            boardStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            boardStackView.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            
            boardStackView.heightAnchor.constraint(equalTo: boardStackView.widthAnchor)
        ])
    }
    
    // MARK: - Actions
    @objc private func menuButtonTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @objc private func fieldButtonPressed(_ sender: UIButton) {
        let index = sender.tag
        
        // Защита от клика по занятой клетке
        guard board[index] == 0 else { return }
        
        // Определяем, чей сейчас ход
        let isCurrentMoveX = computer ? true : (turn == "X")
        
        // Выполняем ход
        performMove(isX: isCurrentMoveX, at: index)
        
        // Проверяем условия окончания игры
        if checkGameEnd(isX: isCurrentMoveX) {
            return
        }
        
        // Передаём ход дальше
        if computer {
            disableBoardInteraction()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
                self?.computerMove()
            }
        } else {
            turn = isCurrentMoveX ? "O" : "X"
            turnImage.image = UIImage(named: turn == "X" ? "icons8-x-100" : "icons8-o-100")
        }
    }
    
    // MARK: - Game Helpers
    
    /// Выполняет ход: обновляет массив board, рисует картинку на кнопке и отключает её
    private func performMove(isX: Bool, at index: Int) {
        let player = isX ? playerX : playerO
        let boardValue = isX ? 1 : 2
        let imageName = isX ? "icons8-x-100" : "icons8-o-100"
        
        player.MakeMove(cell: index) { self.board[index] = boardValue }
        boardButtons[index].setImage(UIImage(named: imageName), for: .normal)
        boardButtons[index].isEnabled = false
    }
    
    /// Проверяет победу или ничью. Возвращает true, если игра окончена.
    private func checkGameEnd(isX: Bool) -> Bool {
        let player = isX ? playerX : playerO
        let winnerName = computer ? (isX ? "игрока!" : "компьютера!") : (isX ? "игрока X!" : "игрока O!")
        
        if winCondition(player: player.move) {
            showAlert(title: "Победа \(winnerName)", message: "Хотели бы вы начать заново?")
            return true
        } else if checkDraw() {
            showAlert(title: "Ничья", message: "Хотели бы вы начать заново?")
            return true
        }
        return false
    }
    
    /// Логика хода компьютера
    private func computerMove() {
        let movePC = pcMove(board: board, player: playerX.move, pc: playerO.move)
        performMove(isX: false, at: movePC)
        
        if !checkGameEnd(isX: false) {
            enableBoardInteraction()
        }
    }
    
    private func disableBoardInteraction() {
        boardButtons.forEach { $0.isUserInteractionEnabled = false }
    }
    
    private func enableBoardInteraction() {
        boardButtons.forEach { $0.isUserInteractionEnabled = true }
    }
    
    // MARK: - AI Logic
    
    private func pcMove(board: [Int], player: [Int?], pc: [Int?]) -> Int {
        switch dif {
        case 1:
            return centerMove() ?? randomMove()
        case 2:
            return abusePlayer(player: player) ?? centerMove() ?? randomMove()
        case 3:
            return winningMove(pc: pc) ?? abusePlayer(player: player) ?? centerMove() ?? randomMove()
        default:
            return randomMove()
        }
    }
    
    private func randomMove() -> Int {
        var move = Int.random(in: 0...8)
        while board[move] != 0 {
            move = Int.random(in: 0...8)
        }
        return move
    }
    
    private func centerMove() -> Int? {
        return board[4] == 0 ? 4 : nil
    }
    
    private func winningMove(pc: [Int?]) -> Int? {
        let movePC = Set(pc.compactMap { $0 })
        for elem in winningSet {
            let pos = elem.subtracting(movePC)
            if pos.count == 1, let first = pos.first, board[first] == 0 {
                return first
            }
        }
        return nil
    }
    
    private func abusePlayer(player: [Int?]) -> Int? {
        let movePlayer = Set(player.compactMap { $0 })
        for elem in winningSet {
            let pos = elem.subtracting(movePlayer)
            if pos.count == 1, let first = pos.first, board[first] == 0 {
                return first
            }
        }
        return nil
    }
    
    private func checkDraw() -> Bool {
        return board.allSatisfy { $0 != 0 }
    }
    
    private func winCondition(player: [Int?]) -> Bool {
        let move = Set(player.compactMap { $0 })
        return winningSet.contains { $0.isSubset(of: move) }
    }
    
    // MARK: - Reset & Alert
    
    private func resetGame() {
        for i in 0...8 {
            boardButtons[i].setImage(nil, for: .normal)
            boardButtons[i].isEnabled = true
            boardButtons[i].isUserInteractionEnabled = true
        }
        turn = "X"
        turnImage.image = UIImage(named: "icons8-x-100")
        board = Array(repeating: 0, count: 9)
        playerX.move = Array(repeating: nil, count: 9)
        playerO.move = Array(repeating: nil, count: 9)
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "Да", style: .default) { [weak self] _ in
            self?.resetGame()
        }
        let noAction = UIAlertAction(title: "Нет", style: .default) { [weak self] _ in
            self?.dismiss(animated: true)
        }
        alert.addAction(yesAction)
        alert.addAction(noAction)
        present(alert, animated: true)
    }
}
