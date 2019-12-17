//
//  ViewController.swift
//  CrashAnalyzer
//
//  Created by wxiubin on 2019/12/16.
//  Copyright © 2019 wxiubin. All rights reserved.
//

import Cocoa

class MainViewController: NSViewController, NSTextFieldDelegate {
    
    @IBOutlet private weak var logFileTextField: NSTextField!
    @IBOutlet private weak var dsymTextField: NSTextField!
    
    @IBOutlet private weak var parserButton: NSButton!
    
    @IBOutlet private weak var resultView: NSScrollView!
    
    var logFielPath: String? {
        didSet {
            logFileTextField.stringValue = logFielPath ?? ""
        }
    }
    
    var dsymPath: String? {
        didSet {
            dsymTextField.stringValue = dsymPath ?? ""
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _setupTextField(logFileTextField)
        _setupTextField(dsymTextField)
    }
    
    func _setupTextField(_ textField: NSTextField) {
        textField.delegate = self
        textField.isEditable = false
        textField.target = self
        textField.target = self
        
        let click = NSClickGestureRecognizer()
        click.target = self
        click.action = Selector(("_clicked:"))
        textField.addGestureRecognizer(click)
    }
    
    @IBAction func _clicked(_ sender: NSClickGestureRecognizer) {
        
        let isLogFile = sender.view == logFileTextField
        
        let textField = isLogFile ? logFileTextField : dsymTextField
        
        
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
    
    @IBAction func _parse(_ sender: NSButton) {
    
    }
    
    func control(_ control: NSControl, textShouldBeginEditing fieldEditor: NSText) -> Bool {
        return false;
    }
}
