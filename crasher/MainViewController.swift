//
//  ViewController.swift
//  crasher
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
    
    }
    
    @IBAction func _parse(_ sender: NSButton) {
    
    }
    
    func control(_ control: NSControl, textShouldBeginEditing fieldEditor: NSText) -> Bool {
        return false;
    }
}
