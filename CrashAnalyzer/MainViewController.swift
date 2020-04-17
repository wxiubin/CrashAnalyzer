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
    
    @IBOutlet weak var indicator: NSProgressIndicator!
    
    var isAnalyzing = false {
        didSet {
            analyzeButton.isEnabled = !isAnalyzing
            indicator.isHidden = !isAnalyzing
            if isAnalyzing {
                indicator.startAnimation(nil)
            } else {
                indicator.stopAnimation(nil)
            }
        }
    }
    
    
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
        click.action = #selector(self._clickedTextField(_:))
        textField.addGestureRecognizer(click)
    }
    
    func _openFileChannel(_ islog: Bool) -> Void {
        
        let textField = islog ? crashTextField : dsymTextField
        
        let openChannel = NSOpenPanel()
        openChannel.title = islog ? "选择日志文件" : "选择符号表文件"
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
    
    @IBAction func _selectDSYM(_ sender: Any) {
        _openFileChannel(false)
    }
    @IBAction func _selectFile(_ sender: Any) {
        _openFileChannel(true)
    }
    @IBAction func _clickedTextField(_ sender: NSClickGestureRecognizer) {
        _openFileChannel(sender.view == crashTextField)
    }
    
    @IBAction func _analyze(_ sender: NSButton) {
        
        if isAnalyzing {
            return
        }
        isAnalyzing = true
        
        let crashPath = crashTextField.stringValue ;
        let dsymPath = dsymTextField.stringValue ;
        if crashPath.isEmpty || dsymPath.isEmpty {
            resultView.string = "请选择日志文件和符号表"
            return
        }
        let crashUrl = URL(string: crashPath)
        let dsymUrl = URL(string: dsymPath)
        Dispatch.DispatchQueue.global().async {
            let result = Analyzer().analyze(dsym: dsymUrl!.path, crash: crashUrl!.path)
            DispatchQueue.main.async {
                self.resultView.string = result
                self.isAnalyzing = false
            }
        }
    }
    
    // 禁止手动输入
    func control(_ control: NSControl, textShouldBeginEditing fieldEditor: NSText) -> Bool {
        return false;
    }
}
