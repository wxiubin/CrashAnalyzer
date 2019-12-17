//
//  ViewController.swift
//  CrashAnalyzer
//
//  Created by wxiubin on 2019/12/16.
//  Copyright © 2019 wxiubin. All rights reserved.
//

import Cocoa

class MainViewController: NSViewController, NSTextFieldDelegate {
    
    @IBOutlet private weak var crashTextField: NSTextField!
    @IBOutlet private weak var dsymTextField: NSTextField!
    
    @IBOutlet private weak var analyzeButton: NSButton!
    
    @IBOutlet private weak var resultView: NSTextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _setupTextField(crashTextField)
        _setupTextField(dsymTextField)
    }
    
    func _setupTextField(_ textField: NSTextField) {
        textField.delegate = self
        textField.isEditable = false
        textField.target = self
        textField.target = self
        
        let click = NSClickGestureRecognizer()
        click.target = self
        click.action = Selector(("_clickedTextField:"))
        textField.addGestureRecognizer(click)
    }
    
    @IBAction func _clickedTextField(_ sender: NSClickGestureRecognizer) {
        
        let isLogFile = sender.view == crashTextField
        
        let textField = isLogFile ? crashTextField : dsymTextField
        
        
        let openChannel = NSOpenPanel()
        openChannel.title = isLogFile ? "选择日志文件" : "选择符号表文件"
        openChannel.begin { (respone) in
            if respone.rawValue == 0 {
                print("取消选择");
                return
            } else {
                print("选中文件：\(String(describing: openChannel.urls.first))")
            }
            let filePath = openChannel.urls.first?.absoluteString
            if filePath?.isEmpty == false {
                textField?.stringValue = filePath!
            }
        }
    }
    
    @IBAction func _analyze(_ sender: NSButton) {
        
        let crashPath = crashTextField.stringValue ;
        let dsymPath = dsymTextField.stringValue ;
        if crashPath.isEmpty || dsymPath.isEmpty {
            resultView.string = "请选择日志文件和符号表"
            return
        }
        let crashUrl = URL(string: crashPath)
        let dsymUrl = URL(string: dsymPath)
        let result = Analyzer().analyze(dsym: dsymUrl!.path, crash: crashUrl!.path)
        resultView.string = result
    }
    
    // 禁止手动输入
    func control(_ control: NSControl, textShouldBeginEditing fieldEditor: NSText) -> Bool {
        return false;
    }
}
