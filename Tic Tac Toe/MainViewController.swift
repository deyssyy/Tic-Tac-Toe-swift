//
//  ViewController.swift
//  Tic Tac Toe
//
//  Created by nikita on 12.11.2023.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var DifLabel: UILabel!
    @IBOutlet weak var button0: UIButton!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    @IBOutlet weak var button6: UIButton!
    @IBOutlet weak var button7: UIButton!
    @IBOutlet weak var button8: UIButton!
    @IBOutlet weak var TurnImage: UIImageView!
    @IBOutlet weak var TurnLabel: UILabel!
    
    @IBOutlet var buttons: [UIButton]!
    
    @IBOutlet var images: [UIImageView]!
    
    var WinningSet : Set<Set<Int>> = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
    var board = [0,0,0,0,0,0,0,0,0]
    
    var diffarr = ["Лёгкий","Нормальный","Сложный","Непобедимый"]
    let dif = UserDefaults.standard.integer(forKey: "DifLevel")
    var IncomeSegueID = ""
    var playerX = Player()
    var playerO = Player()
    var computer = false
    var turn = "X"
    @IBAction func abbba(_ sender: Any) {
        Alert(title: "ggg", message: "asa", style: .alert)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DifLabel.text = "Сложность: \(diffarr[dif])"
        TurnImage.image = UIImage(named: "icons8-x-100")
        if IncomeSegueID == "OnePlayer"{
            TurnImage.isHidden = true
            TurnLabel.isHidden = true
            computer = true
        }else{
            DifLabel.isHidden = true
        }
        ResetGame()
    }

    @IBAction func MenuButtonTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func FiledButtonPressed(_ sender: UIButton) {
        if computer{
            playerX.MakeMove(cell: sender.tag){board[sender.tag] = 1}
            images[sender.tag].image = UIImage(named: "icons8-x-100")
            sender.isEnabled = false
            for elem in buttons{
                elem.isUserInteractionEnabled = false
            }
            if wincondition(player: playerX.move){
                Alert(title: "Победа игрока!", message: "Хотели бы вы начать заново?", style: .alert)
            }else if CheckDraw(){
                Alert(title: "Ничья", message: "Хотели бы вы начать заново?", style: .alert)
            }
            
            else{
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                    let movePC = self.pcMove(board: self.board, player: self.playerX.move, PC: self.playerO.move)
                    self.playerO.MakeMove(cell: movePC){self.board[movePC] = 2}
                    self.images[movePC].image = UIImage(named: "icons8-o-100")
                    self.buttons[movePC].isEnabled = false
                    if self.wincondition(player: self.playerO.move){
                        self.Alert(title: "Победа компьютера!", message: "Хотели бы вы начать заново?", style: .alert)
                    }
                    for elem in self.buttons{
                        elem.isUserInteractionEnabled = true
                    }
                }
            }
        }else{
            if turn == "X"{
                turn = "O"
                playerX.MakeMove(cell: sender.tag){board[sender.tag] = 1}
                images[sender.tag].image = UIImage(named: "icons8-x-100")
                sender.isEnabled = false
                if wincondition(player: playerX.move){
                    Alert(title: "Победа игрока X!", message: "Хотели бы вы начать заново?", style: .alert)
                }else if CheckDraw(){
                    Alert(title: "Ничья", message: "Хотели бы вы начать заново?", style: .alert)
                }
                TurnImage.image = UIImage(named: "icons8-o-100")
            }else{
                turn = "X"
                playerO.MakeMove(cell: sender.tag){board[sender.tag] = 2}
                images[sender.tag].image = UIImage(named: "icons8-o-100")
                sender.isEnabled = false
                if wincondition(player: playerO.move){
                    Alert(title: "Победа игрока O!", message: "Хотели бы вы начать заново?", style: .alert)
                }
                TurnImage.image = UIImage(named: "icons8-x-100")
            }
        }
      

    }
    
    private func pcMove(board: [Int], player: [Int?], PC: [Int?]) -> Int {
        let WinningSet : Set<Set<Int>> = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
        var move: Int
        
        switch dif{
        case 1:
            if CenterMove() != nil {
                move = CenterMove()!
                return move
            }else{
                return RandomMove()
            }
        case 2:
            if AbusePlayer(player: player) != nil{
                move = AbusePlayer(player: player)!
                return move
            }else if CenterMove() != nil {
                move = CenterMove()!
                return move
            }else{
                return RandomMove()
            }
        case 3:
            if WinningMove(PC: PC) != nil{
                move = WinningMove(PC: PC)!
                return move
            }else if AbusePlayer(player: player) != nil{
                move = AbusePlayer(player: player)!
                return move
            }else if CenterMove() != nil {
                move = CenterMove()!
                return move
            }else{
                return RandomMove()
            }
        default:
            return RandomMove()
        }
    }
    
    private func RandomMove() -> Int{
        var move = Int.random(in: 0...8)
        while board[move] != 0{
            move = Int.random(in: 0...8)
        }
        return move
    }
    
    private func CenterMove() -> Int?{
        if board[4] == 0{
            return 4
        }
        return nil
    }
    
    private func WinningMove(PC: [Int?]) -> Int?{
        let movePC = Set(PC.compactMap{$0})
        for elem in WinningSet{
            let pos = elem.subtracting(movePC)
            if pos.count == 1 && board[pos.first!] == 0{
                return pos.first!
            }
        }
        return nil
    }
    
    private func AbusePlayer(player: [Int?]) -> Int?{
        let moveplayer = Set(player.compactMap{$0})
        for elem in WinningSet{
            let pos = elem.subtracting(moveplayer)
            if pos.count == 1 && board[pos.first!] == 0{
                return pos.first!
            }
        }
        return nil
    }
    
    private func CheckDraw() -> Bool {
        let newboard = board.filter{$0 == 0}
        if newboard.isEmpty{
            return true
        }
        return false
    }
    
    private func wincondition(player: [Int?]) -> Bool{
        let move = Set(player.compactMap{$0})
        for elem in WinningSet{
            if elem.isSubset(of: move){
                return true
            }
        }
        return false
    }
    
    private func ResetGame(){
        for i in 0...8{
            images[i].image = nil
            buttons[i].isEnabled = true
            buttons[i].isUserInteractionEnabled = true
        }
        turn = "X"
        TurnImage.image = UIImage(named: "icons8-x-100")
        board = Array(repeating: 0, count: 9)
        playerX.move = Array(repeating: nil, count: 9)
        playerO.move = Array(repeating: nil, count: 9)
    }
    
    private func DrawBoard(){
        for elem in board{
            if elem == 1{
                images[elem].image = UIImage(named: "icons8-x-100")
            }else if elem == 2{
                images[elem].image = UIImage(named: "icons8-o-100")
            }
        }
    }
   
    private func Alert(title: String, message: String, style: UIAlertController.Style)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        let alertactionYes = UIAlertAction(title: "Да", style: .default){_ in
            self.ResetGame()
        }
        let alertactionNo = UIAlertAction(title: "Нет", style: .default){_ in
            self.dismiss(animated: true)
        }
        alert.addAction(alertactionYes)
        alert.addAction(alertactionNo)
        self.present(alert, animated: true)
    }
}

