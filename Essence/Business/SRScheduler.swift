//
//  SRScheduler.swift
//  Essence
//
//  Created by Cole Riggle on 3/1/21.
//

import Foundation

class SRScheduler {
    
    // Based loosely off the SuperMemo algorithm
    // more info at -> https://www.supermemo.com/en/archives1990-2015/english/ol/sm2
    func calculateNextDate(note: Note) {
        
        let baseQ = 4.0;
        
        // EF':=EF+(0.1-(5-q)*(0.08+(5-q)*0.02))
        
        let a = 0.1 - (5.0 - baseQ)
        let b = 0.08 + (5.0 - baseQ) * 0.02
        
        var nextInterval: Double = note.previousInterval as! Double + (a * b)
        
        if (nextInterval < 1.3) {
            nextInterval = 1.3
        }
        
        nextInterval = ceil(nextInterval)
        
        print("Interval chaning from: \(note.previousInterval!) to \(nextInterval)")
        
        note.previousInterval = NSNumber(value: nextInterval)
        note.dueDate = Calendar.current.date(byAdding: .day, value: Int(nextInterval), to: Date())!
    }
}
