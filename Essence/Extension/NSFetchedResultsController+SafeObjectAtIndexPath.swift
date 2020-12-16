//
//  NSFetchedResultsController+SafeObjectAtIndexPath.swift
//  This extension prevents the 'no object at index in section at index' exception.
//
//  Copyright (c) 2016 Thiago Pereira
//  MIT License, http://www.opensource.org/licenses/mit-license.php
//  Source: https://gist.github.com/The0racle/3b6c0e9d8c73c4b1727605117af5e213

import CoreData

extension NSFetchedResultsController {
    
    /// Check whether provided indexPath is valid.
    ///
    /// - note: This method checks if self.section is greater than indexPath.section
    /// and if number of object in indexPath.section is greater than indexPath.row
    ///
    /// - parameter indexPath: indexPath to be checked.
    ///
    /// - returns: Whether indexPath has a value associated to it.
    @objc private func hasObject(at indexPath : NSIndexPath) -> Bool{
        guard let sections = self.sections, sections.count > indexPath.section else {
            return false
        }
        
        let sectionInfo = sections[indexPath.section]
        
        guard sectionInfo.numberOfObjects > indexPath.row else {
            return false
        }
        
        return true
    }
    
    
    /// Check whether the object exists and returns it if true.
    ///
    /// - parameter indexPath: Indexpath of object.
    ///
    /// - returns: Object at indexPath if exists. Nil otherwise.
    @objc func exceptionFreeObject(at indexPath : NSIndexPath) -> AnyObject?{
        guard self.hasObject(at: indexPath) else {
            return nil
        }
        
        return self.object(at: indexPath as IndexPath)
    }
}
