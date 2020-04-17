//
//  Analyzer.swift
//  CrashAnalyzer
//
//  Created by wxiubin on 2019/12/17.
//  Copyright © 2019 wxiubin. All rights reserved.
//

import Cocoa

class Analyzer: NSObject {
    
    public static let analyzer = Analyzer()
    
    let launchPath = "/bin/bash"
    
    let environment = ["DEVELOPER_DIR": "/Applications/Xcode.app/Contents/Developer"]
    
    var symbolicatecrash: String?
    
    public func analyze(dsym: String, crash: String) -> String {
        if symbolicatecrash == nil {
            findSymbolicate()
        }
        let script = symbolicatecrash! + " " + crash + " " + dsym
        return excute(launchPath:launchPath , command: script, environment:environment)
    }
    
    func findSymbolicate() {
        
        let fix = """
            if [ -f "/Applications/Xcode.app/Contents/SharedFrameworks/DVTFoundation.framework/Versions/A/Resources/symbolicatecrash" ];then
                echo "0"
            else
                echo "-1"
            fi
        """
        if excute(launchPath: launchPath, command: fix, environment: nil) == "0" {
            symbolicatecrash = "/Applications/Xcode.app/Contents/SharedFrameworks/DVTFoundation.framework/Versions/A/Resources/symbolicatecrash"
        } else {
            let script = "find /Applications/Xcode.app -name symbolicatecrash -type f | tail -1"
            symbolicatecrash = excute(launchPath: launchPath, command: script, environment:nil)
        }
    }
}
