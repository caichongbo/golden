
import UIKit

let filiter =  "zhang7li"

class ChatViewController: UIViewController,ChatDataSource,UITextFieldDelegate {
    
    //    let socket = SocketIOClient(socketURL: "http://192.168.82.120:81", opts: [
    //        "reconnects": true, // default true
    //        "reconnectAttempts": 5, // default -1 (infinite tries)
    //        "reconnectWait": 5, // default 10
    //        "nsp": "swift", // connects to the specified namespace. Default is /
    //        "forcePolling": true // if true, the socket will only use XHR polling, default is false (polling/WebSockets)
    //        ])
    
    let socket = SocketIOClient(socketURL: "http://192.168.92.202:81")
    
    var Chats:NSMutableArray!
    var tableView:TableView!
    var me:UserInfo!
    var you:UserInfo!
    var txtMsg:UITextField!
    let sendHeight: CGFloat = 50
    var w:CGFloat = 0
    var h:CGFloat = 0
    var subView = UIView()
    
    init(me:UserInfo,you:UserInfo){
        self.me = UserInfo(id:me.userid,name: me.username,logo:me.avatar)
        self.you = UserInfo(id:you.userid,name: you.username,logo:you.avatar)
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func hiddenBoard() {
        txtMsg.resignFirstResponder()
    }
    
    func textFieldDidBeginEditing(textField: UITextField){
        UIView.animateWithDuration(0, animations: {
            self.subView.frame.origin.y = -290
        })
    }
    
    
    func textFieldShouldReturn(textField:UITextField) -> Bool{
        sendMessage()
        self.txtMsg.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField){
        UIView.animateWithDuration(0, animations: {
            self.subView.frame.origin.y = 0
        })
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        w = view.frame.width
        h = view.frame.height
        let tapRec = UITapGestureRecognizer(target: self, action:Selector("hiddenBoard"))
        tapRec.cancelsTouchesInView = false//定义手势的同时不覆盖cell的点击事件
        self.navigationController?.navigationBar.hidden =  false//关闭头部全局导航条
        rootController.showOrhideToolbar(false)
        view.backgroundColor = UIColor(rgb: 0xf3f4f6)
        
        subView.frame = CGRect(x: 0, y: 0, width: w, height: h)
        subView.backgroundColor = UIColor(rgb: 0xf3f4f6)
        
        self.view.addSubview(subView)
        
        title = you.username
        // Do any additional setup after loading the view, typically from a nib.
        
        setupChatTable()
        setupSendPanel()
        addHandlers()
        self.tableView.addGestureRecognizer(tapRec)
    }
    
    
    
    func setupSendPanel(){
        var sendView = UIView(frame:CGRectMake(0,self.h-sendHeight,w,sendHeight))
        sendView.backgroundColor = UIColor(white: 250/255, alpha: 1)
        txtMsg = UITextField(frame:CGRectMake(7,10,w-100,sendHeight-20))
        txtMsg.backgroundColor = UIColor.whiteColor()
        txtMsg.textColor=UIColor.blackColor()
        txtMsg.font=UIFont.systemFontOfSize(14)
        txtMsg.textColor = UIColor.darkGrayColor()
        txtMsg.layer.borderWidth = 0.5
        txtMsg.layer.cornerRadius = 5 //设置圆角
        txtMsg.layer.borderColor = UIColor(red: 200/255, green: 200/255, blue: 205/255, alpha:1).CGColor//设置边框颜色
        txtMsg.returnKeyType = UIReturnKeyType.Done
        
        //设置缩进
        let ui:UIView = UIView(frame: CGRectMake(0,0,8,5))
        txtMsg.leftView = ui
        txtMsg.leftViewMode = UITextFieldViewMode.Always
        
        //Set the delegate so you can respond to user input
        txtMsg.delegate=self
        sendView.addSubview(txtMsg)
        self.subView.addSubview(sendView)
        
        var sendButton = UIButton(frame:CGRectMake(txtMsg.frame.width+11.5,10,77,sendHeight-20))
        sendButton.backgroundColor=UIColor.lightGrayColor()
        sendButton.addTarget(self, action:Selector("sendMessage") ,forControlEvents:UIControlEvents.TouchUpInside)
        sendButton.layer.cornerRadius=5
        sendButton.setTitle("发送", forState:UIControlState.Normal)
        sendView.addSubview(sendButton)
    }
    
    
    
    
    
    
    
//    func  textFieldShouldEndEditing(textField: UITextField) -> Bool{
//        UIView.animateWithDuration(0, animations: {
//            self.subView.frame.origin.y = 0
//        })
//        return true
//    }
    
   
    
    
    func addHandlers(){
        socket.on("broadcast") {data, ack in
            println("Message for you! \(data?[0])")
            if let x: AnyObject = data?[0] {
                let chat = x as! String
                let ary = chat.componentsSeparatedByString(filiter)
                if ary[2] == self.me.userid && ary[0] == self.you.userid {
                    var thatChat = MessageItem(body:ary[4], user:self.you, date:NSDate(), mtype: ChatType.Someone)
                    self.Chats.addObject(thatChat)
                    self.tableView.reloadData()
                }
                //                var thatChat = MessageItem(body:ary[4], user:self.you, date:NSDate(), mtype: ChatType.Someone)
                //                self.Chats.addObject(thatChat)
                //                self.tableView.reloadData()
            }
        }
        socket.connect()
    }
    
    
    
    func sendMessage(){
        //composing=false
        var sender = txtMsg
        if sender.text != "" {
            let chat = me.userid+filiter+me.username+filiter+you.userid+filiter+you.username+filiter+sender.text
            self.socket.emit("broadcast", chat)
            
            var thisChat =  MessageItem(body:sender.text, user:me, date:NSDate(), mtype:ChatType.Mine)
            
            Chats.addObject(thisChat)
            self.tableView.reloadData()
            sender.resignFirstResponder()
            sender.text = ""
        }
    }
    
    
    func setupChatTable(){
        self.tableView = TableView(frame:CGRectMake(0, 20, self.view.frame.width, self.view.frame.height - 100))
        self.tableView.keyboardDismissMode = .Interactive
        //创建一个重用的单元格
        self.tableView!.registerClass(TableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        Chats = NSMutableArray()
        self.tableView.chatDataSource = self
        self.subView.addSubview(self.tableView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldResignFirstResponder(){
        txtMsg.resignFirstResponder()
    }
    
    func rowsForChatTable(tableView:TableView) -> Int{
        if let op = self.Chats{
            return self.Chats.count
        }
        return 0
    }
    
    func chatTableView(tableView:TableView, dataForRow row:Int) -> MessageItem{
        if let op = self.Chats{
            return Chats[row] as! MessageItem
        }
        return MessageItem(body: "", user:self.you, date:NSDate(), mtype: ChatType.Someone)
    }
    
    override func viewDidDisappear(animated: Bool){
        if animated {
            self.socket.close(fast: true)
        }
    }
}

