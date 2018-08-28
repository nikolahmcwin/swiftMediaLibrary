//
//  FileImporter.swift
//  MediaLibraryManager
//
//  Created by Nikolah Pearce and Vivian Breda on 14/08/18.
//  Copyright © 2018 Paul Crane. All rights reserved.
//

import Foundation

/**
 The list of exceptions that can be thrown by the Validation handler
 */
enum MMValidationError : Error {
    
    // Thrown if there is something wrong with the type of media
    case invalidType
    
    // Thrown if there is something wrong with metadata for a specific type
    // e.g. image does not have resolution
    case invalidMetadataForType
}

/**
Support struct for reading JSON data in.
*/
struct Media : Codable {
	let fullpath: String
	let type: String
	let metadata: [String: String]
}

/**
Reads media in from JSON files.

Performs deserialisation of json data into media struct.
Validates the found media and prints/catches any errors thrown.
*/
class FileImporter : MMFileImport {
	
	/**
	Support importing the media collection from a file (by name)
	
	- parameter filename: the full path to the file including file name.
	- returns: [MMFile]: the array of files read successfully
	*/
	func read(filename: String) throws -> [MMFile] {
	
		var filesValidated : [MMFile] = []
		
        do {
			
			let fileManager = FileManager.default
			var filePath: URL
			
			// Create full file path depending on user input
			if filename.hasPrefix("/") || filename.hasPrefix("~") {
				let directory = NSString(string: filename).expandingTildeInPath
				filePath = URL(fileURLWithPath: directory)
			} else {
				let working = fileManager.currentDirectoryPath
				let workingDirectory = URL(fileURLWithPath: working)
				//print(workingDirectory)
				filePath = workingDirectory.appendingPathComponent(filename)
			}

			// Decode the json data into array of Media structs
            let decoder = JSONDecoder()
            var mediaArray : [Media] = []
            
            do {
                let data = try Data(contentsOf: filePath)
				mediaArray = try decoder.decode([Media].self, from: data)
            } catch {
                print("> Invalid JSON file...")
				print("\tCheck your filename and/or contents and try again.")
            }
			
			
			// Convert from Media struct into true File, if valid
			let validator: FileValidator = FileValidator()
			
			for m in mediaArray {
				if let validatedFile = try validator.validate(media: m) {
					filesValidated.append(validatedFile)
				}
			}
			
			// Check for any files not loaded
			let errors = validator.getErrorMessages()
			let numErrors = errors.count
			if numErrors > 0 {
				if numErrors == 1 {
					print("> \(errors.count) file not loaded")
				} else {
					print("> \(errors.count) files not loaded")
				}
				var i: Int = 1
				for e in errors {
					print("\t\(i): \(e)")
					i += 1
				}
			}
        } catch MMValidationError.invalidType {
            print("> Invalid file type, expecting image document audio or video.")
        } catch MMValidationError.invalidMetadataForType {
            print("> Invalid metadata for provided media type.")
        }
		
		return filesValidated
	}
}

