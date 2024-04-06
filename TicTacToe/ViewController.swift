import UIKit

class ViewController: UIViewController {
    
    enum Turn {
        case circle // 圈圈玩家
        case cross // 叉叉玩家
    }

    @IBOutlet weak var whosTurnLabel: UILabel! // 顯示當前輪次的標籤
    @IBOutlet weak var a1Btn: UIButton! // 遊戲板上的按鈕
    @IBOutlet weak var a2Btn: UIButton!
    @IBOutlet weak var a3Btn: UIButton!
    @IBOutlet weak var a4Btn: UIButton!
    @IBOutlet weak var a5Btn: UIButton!
    @IBOutlet weak var a6Btn: UIButton!
    @IBOutlet weak var a7Btn: UIButton!
    @IBOutlet weak var a8Btn: UIButton!
    @IBOutlet weak var a9Btn: UIButton!
    
    var firstTurn = Turn.circle // 遊戲開始時的第一個玩家
    var currentTurn = Turn.circle // 目前的輪次
    var circle = "O" // 圈圈玩家的標記
    var cross = "X" // 叉叉玩家的標記
    var board = [UIButton]() // 存儲所有遊戲按鈕的陣列
    var circleScore:Int = 0 // 圈圈玩家的分數
    var crossScore:Int = 0 // 叉叉玩家的分數
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initBoard() // 初始化遊戲
    }

    // 初始化遊戲板，將所有遊戲按鈕添加到陣列中
    func initBoard() {
        board.append(a1Btn)
        board.append(a2Btn)
        board.append(a3Btn)
        board.append(a4Btn)
        board.append(a5Btn)
        board.append(a6Btn)
        board.append(a7Btn)
        board.append(a8Btn)
        board.append(a9Btn)
    }
    
    // 當玩家點擊遊戲板上的任何按鈕時執行
    @IBAction func boardTapAvtion(_ sender: UIButton) {
        addToBoard(sender) // 處理按鈕點擊
        
        // 檢查遊戲狀態並顯示適當的警告
        if checkForVictory(circle) {
            circleScore += 1
            resultAlert(title: "圈圈 贏了!")
        }
        if checkForVictory(cross) {
            crossScore += 1
            resultAlert(title: "叉叉 贏了!")
        }
        if fullBoard() {
            resultAlert(title: "平手")
        }
    }
    
    // 檢查指定玩家是否勝利
    func checkForVictory(_ s : String) -> Bool {
        if thisSymbol(a1Btn, s) && thisSymbol(a2Btn, s) && thisSymbol(a3Btn, s){
            return true
        }
        if thisSymbol(a4Btn, s) && thisSymbol(a5Btn, s) && thisSymbol(a6Btn, s){
            return true
        }
        if thisSymbol(a7Btn, s) && thisSymbol(a8Btn, s) && thisSymbol(a9Btn, s){
            return true
        }
        if thisSymbol(a1Btn, s) && thisSymbol(a4Btn, s) && thisSymbol(a7Btn, s){
            return true
        }
        if thisSymbol(a2Btn, s) && thisSymbol(a5Btn, s) && thisSymbol(a8Btn, s){
            return true
        }
        if thisSymbol(a3Btn, s) && thisSymbol(a6Btn, s) && thisSymbol(a9Btn, s){
            return true
        }
        if thisSymbol(a1Btn, s) && thisSymbol(a5Btn, s) && thisSymbol(a9Btn, s){
            return true
        }
        if thisSymbol(a3Btn, s) && thisSymbol(a5Btn, s) && thisSymbol(a7Btn, s){
            return true
        }
        return false
    }
    
    // 判斷指定的按鈕是否為指定的符號
    func thisSymbol(_ button: UIButton, _ symbol: String) ->Bool {
        return button.title(for: .normal) == symbol
    }
    
    // 顯示結果的警告框，並提供重新開始遊戲的選項
    func resultAlert(title: String) {
        // 創建顯示分數的消息內容
        let message = "\n圈圈分數: \(circleScore)分！\n\n叉叉分數: \(crossScore)分！"
        // 創建警告控制器，並設置其消息內容為剛剛建立的message字符串
        let allClear = UIAlertController(title: title, message: message, preferredStyle: .alert)
        // 添加一個按鈕讓用戶可以選擇"重來一次"
        allClear.addAction(UIAlertAction(title: "重來一次", style: .default, handler: { (_) in self.resetBoard() }))
        // 展示警告控制器
        self.present(allClear, animated: true)
    }

    // 重設遊戲板，準備下一輪遊戲
    func resetBoard() {
        for button in board {
            button.setTitle(nil, for: .normal)
            button.isEnabled = true
        }
        if firstTurn == Turn.cross {
            firstTurn = Turn.circle
            whosTurnLabel.text = circle
        } else if firstTurn == Turn.circle {
            firstTurn = Turn.cross
            whosTurnLabel.text = cross
        }
        currentTurn = firstTurn
    }
    
    // 檢查遊戲板是否已滿，即所有格子都被選過
    func fullBoard() -> Bool {
        // 如果有任何一個按鈕的標題是nil，表示還有格子未被選擇，遊戲板未滿
        for button in board {
            if button.title(for: .normal) == nil {
                return false
            }
        }
        // 所有按鈕都已經有標題（被選擇過），表示遊戲板已滿
        return true
    }
    
    // 處理玩家在遊戲板上的選擇動作
    func addToBoard(_ sender: UIButton) {
        // 檢查被選擇的按鈕是否未被選過（標題為nil）
        if sender.title(for: .normal) == nil {
            // 根據當前輪次設置按鈕標題（"O"或"X"），並更新輪次
            if currentTurn == Turn.circle {
                sender.setTitle(circle, for: .normal) // 設置為圈圈玩家的標記
                currentTurn = Turn.cross // 換到叉叉玩家的輪次
                whosTurnLabel.text = cross // 更新顯示當前輪次的標籤
            } else if currentTurn == Turn.cross {
                sender.setTitle(cross, for: .normal) // 設置為叉叉玩家的標記
                currentTurn = Turn.circle // 換到圈圈玩家的輪次
                whosTurnLabel.text = circle // 更新顯示當前輪次的標籤
            }
            sender.isEnabled = false // 禁用被選擇的按鈕，避免重複選擇
        }
    }
    
}
#Preview {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    return storyboard.instantiateViewController(withIdentifier: "ViewController")
}
