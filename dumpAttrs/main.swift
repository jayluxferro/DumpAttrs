//
//  main.swift
//  dumpAttrs
//
//  Created by Jay on 8/11/20.
//  Copyright © 2020 Jay. All rights reserved.
//

import Foundation
import os

func usage(){
    print("\(CommandLine.arguments[0]) <File Name>\nE.g. \(CommandLine.arguments[0]) file.txt")
    os.exit(1)
}


if CommandLine.arguments.count != 2 {
    usage()
}


let fileName = CommandLine.arguments[1].trimmingCharacters(in: .whitespacesAndNewlines)
let fileManager = FileManager.default
if fileManager.fileExists(atPath: fileName){
    if let attrs =  try Xattr.names(atPath: fileName) {
        for attr in attrs {
            print(attr)
        }
    }
}

// MARK:- URL Extension to display xattr
/*
extension URL {
    
    
    private static func posixError(_ err: Int32) -> NSError {
        return NSError(domain: NSPOSIXErrorDomain, code: Int(err), userInfo: [NSLocalizedDescriptionKey: String(cString: strerror(err))])
    }
    /// Get an extended attribute:
    func extendedAttribute(forName name: String) throws -> Data {
        let data = try self.withUnsafeFileSystemRepresentation { fileSystemPath -> Data in
            // Determine the size of the attribute
            let length = getxattr(fileSystemPath, name, nil, 0, 0, 0)
            guard length >= 0 else { throw URL.posixError(errno) }
            // Create a buffer of the required size
            var data = Data(count: length)
            var data_ = data
            
            // Retrieve the attribute and return it
            let result = data_.withUnsafeMutableBytes {
                getxattr(fileSystemPath, name, $0, data.count, 0, 0)
            }
            guard result >= 0 else { throw URL.posixError(errno) }
            return data
        }
        return data
    }
    
    
    
    /// Get a list of all extended attributes:
    func listExtendedAttributes() throws -> [String] {
        let list = try self.withUnsafeFileSystemRepresentation { fileSystemPath -> [String] in
            let length = listxattr(fileSystemPath, nil, 0, 0)
            guard length >= 0 else { throw URL.posixError(errno) }
            // Create a buffer of the required size
            var data = Data(count: length), data2 = Data(count: length)
            // Retrieve the attribute list
            let result = data2.withUnsafeMutableBytes {
                listxattr(fileSystemPath, $0, data.count, 0)
            }
            guard result >= 0 else { throw URL.posixError(errno) }
            // Extract the attribute names into an Array of Strings
            let list = data.split(separator: 0).flatMap {
                String(data: Data($0), encoding: .utf8)
            }
            return list
        }
        return list
    }
    
    /// Set an extended attribute:
    func setExtendedAttribute(data: Data, forName name: String) throws {
        try self.withUnsafeFileSystemRepresentation { fileSystemPath in
            let result = data.withUnsafeBytes {
                setxattr(fileSystemPath, name, $0, data.count, 0, 0)
            }
            guard result >= 0 else { throw URL.posixError(errno) }
        }
    }
    
    /// Remove an extended attribute:
    func removeExtendedAttribute(forName name: String) throws {
        try self.withUnsafeFileSystemRepresentation { fileSystemPath in
            let result = removexattr(fileSystemPath, name, 0)
            guard result >= 0 else { throw URL.posixError(errno) }
        }
    }
}
*/
