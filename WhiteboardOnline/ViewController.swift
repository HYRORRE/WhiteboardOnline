//
//  ViewController.swift
//  WhiteboardOnline
//
//  Created by Moto Shinriki on 2017/08/09.
//  Copyright © 2017年 Moto Shinriki. All rights reserved.
//

import UIKit

class CardViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    private var newButton: UIBarButtonItem!
    
    let cardList: [Card] = [Card()]
    
    @IBAction func goBack(_ segue:UIStoryboardSegue) {}
    
    @IBAction func goNext(_ sender:UIButton) {
        let next = storyboard!.instantiateViewController(withIdentifier: "nextView")
        self.present(next,animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
		
        cardList[0].commentFront = "Hello World!"
        
        // 枠のカラー
        textView.layer.borderColor = UIColor.red.cgColor
        
        // 枠の幅
        textView.layer.borderWidth = 1.0
		
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        // Cell はストーリーボードで設定したセルのID
        let testCell:UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        
        
        // Tag番号を使ってLabelのインスタンス生成
        let label = testCell.contentView.viewWithTag(2) as! UILabel
        label.text = cardList[indexPath.row].commentFront
        
        
        return testCell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // section数は１つ
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // 要素数を入れる、要素以上の数字を入れると表示でエラーとなる
        return cardList.count
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    override func viewWillAppear(_ animated: Bool) {
        newButton = UIBarButtonItem(title: "Create", style: .plain, target: self, action: #selector(TableViewController.onClickMyButton(sender:)))
        
        newButton.tag = 1;
        self.navigationItem.rightBarButtonItem = newButton
    }
    
    internal func onClickMyButton(sender: UIButton){
        
        switch(sender.tag){
            
        case 1:
            // 背景色を青色に変える.
            self.view.backgroundColor = UIColor.blue
            
        case 2:
            // 背景色を赤色に変える.
            self.view.backgroundColor = UIColor.red
            
        default:
            print("error")
        }
    }


}

