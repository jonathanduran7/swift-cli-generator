// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

// MARK: - Helper
func createFolderIfNeeded(at path: String) {
    if !FileManager.default.fileExists(atPath: path) {
        try! FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true)
    }
}

func writeFile(at path: String, content: String) {
    FileManager.default.createFile(atPath: path, contents: content.data(using: .utf8))
}

// MARK: - Entrada CLI
let args = CommandLine.arguments

guard args.count >= 3 else {
    print("❌ Uso: swift run <tool> <Modulo> <NombrePantalla> [--viewmodel]")
    exit(1)
}

let moduleName = args[1]
let screenName = args[2]
let includeViewModel = args.contains("--viewmodel")

let currentPath = FileManager.default.currentDirectoryPath

// MARK: Pahts
let viewFolder = "\(currentPath)/\(moduleName)/View"
let viewModelFolder = "\(currentPath)/\(moduleName)/ViewModel"

createFolderIfNeeded(at: viewFolder)
if includeViewModel { createFolderIfNeeded(at: viewModelFolder) }

// MARK: Templates
let viewControllerContent = """
import UIKit

class \(screenName)ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "\(screenName)"
    }
}
"""

let viewModelContent = """
import Foundation

class \(screenName)ViewModel {
    // TODO: Lógica de view model
}
"""

// MARK: - Crear archivos
let vcPath = "\(viewFolder)/\(screenName)ViewController.swift"
writeFile(at: vcPath, content: viewControllerContent)

if includeViewModel {
    let vmPath = "\(viewModelFolder)/\(screenName)ViewModel.swift"
    writeFile(at: vmPath, content: viewModelContent)
}

print("✅ Se generó el módulo \(moduleName)/ con la pantalla \(screenName).")
if includeViewModel {
    print("🧠 Se incluyó ViewModel también.")
}
