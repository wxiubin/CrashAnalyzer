//
//  Bash.swift
//  CrashAnalyzer
//
//  Created by wxiubin on 2019/12/17.
//  Copyright © 2019 wxiubin. All rights reserved.
//

import Foundation

func excute(launchPath: String, command: String, environment: [String : String]?) -> String
{
    let task = Process()
    task.launchPath = launchPath
    task.arguments = ["-c", command]
    task.environment = environment
    
    let pipe = Pipe()
    task.standardOutput = pipe
    task.launch()
    
    let data = pipe.fileHandleForReading.readDataToEndOfFile()
    var output = String(data: data, encoding: String.Encoding.utf8)!
    if output.count > 0 {
        output.removeLast()
    }
    return output
}
