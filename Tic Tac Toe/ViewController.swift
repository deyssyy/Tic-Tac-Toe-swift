//
//  ViewController.swift
//  Tic Tac Toe
//
//  Created by nikita on 12.11.2023.
//

import UIKit

class ViewController: UIViewController {
    
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
    
    @IBOutlet var buttons: [UIButton]!
    
    @IBOutlet var images: [UIImageView]!
    
    var WinningSet : Set<Set<Int>> = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
    var board = [0,0,0,0,0,0,0,0,0]
    var player = Player()
    var PC = Player()
    var diffarr = ["Лёгкий","Нормальный","Сложный","Непобедимый"]
    let dif = Int(UserDefaults.standard.string(forKey: "DifLevel")!)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DifLabel.text = "Сложность: \(diffarr[dif])"
        ResetGame()
    }

    @IBAction func MenuButtonTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func FiledButtonPressed(_ sender: UIButton) {
        
        player.MakeMove(cell: sender.tag){board[sender.tag] = 1}
        images[sender.tag].image = UIImage(named: "icons8-x-100")
        sender.isEnabled = false
        for elem in buttons{
            elem.isUserInteractionEnabled = false
        }
       if wincondition(player: player.move){
            print("YOU WIN!")
           let alert = UIAlertController(title: "Победа Игрока!", message: "Хотели бы вы начать заново?", preferredStyle: .alert)
           let action = UIAlertAction(title: "Да!", style: .default){ _ in
               self.ResetGame()
           }
           alert.addAction(action)
           self.present(alert, animated: true)
        
       }else if CheckDraw(){
           print("draw")
           let alert = UIAlertController(title: "Ничья", message: "Хотели бы вы начать заново?", preferredStyle: .alert)
           let action = UIAlertAction(title: "Да!", style: .default){ _ in
               self.ResetGame()
           }
           alert.addAction(action)
           self.present(alert, animated: true)
       }
     
        else{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                let movePC = self.pcMove(board: self.board, player: self.player.move, PC: self.PC.move)
                self.PC.MakeMove(cell: movePC){self.board[movePC] = 2}
                self.images[movePC].image = UIImage(named: "icons8-o-100")
                self.buttons[movePC].isEnabled = false
                if self.wincondition(player: self.PC.move){
                    print("PC WIN!")
                    let alert = UIAlertController(title: "Победа Компьютера!", message: "Хотели бы вы начать заново?", preferredStyle: .alert)
                    let action = UIAlertAction(title: "Да!", style: .default){ _ in
                        self.ResetGame()
                    }
                    alert.addAction(action)
                    self.present(alert, animated: true)
                }
                for elem in self.buttons{
                    elem.isUserInteractionEnabled = true
                }
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
        
        
        
        //ход для победы
        /*
        let movePC = Set(PC.compactMap{$0})
        for elem in WinningSet{
            let pos = elem.subtracting(movePC)
            if pos.count == 1 && board[pos.first!] == 0{
                return pos.first!
            }
        }
         
        if WinningMove(PC: PC) != nil {
            move = WinningMove(PC: PC)!
            return move
        }
        
        //ход помешать победе игрока
        /*
        let moveplayer = Set(player.compactMap{$0})
        for elem in WinningSet{
            let pos = elem.subtracting(moveplayer)
            if pos.count == 1 && board[pos.first!] == 0{
                return pos.first!
            }
        }
         */
        if AbusePlayer(player: player) != nil {
            move = AbusePlayer(player: player)!
            return move
        }
       
        //ход на центральную клетку
        /*
        if board[4] == 0{
            return 4
        }
         */
        if CenterMove() != nil {
            move = CenterMove()!
            return move
        }
        
        //ход на рандомную клетку
        /*
        var move = Int.random(in: 0...8)
        while board[move] != 0{
            move = Int.random(in: 0...8)
        }
        */
        return RandomMove()
         */
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
        board = Array(repeating: 0, count: 9)
        player.move = Array(repeating: nil, count: 9)
        PC.move = Array(repeating: nil, count: 9)
    }
}

