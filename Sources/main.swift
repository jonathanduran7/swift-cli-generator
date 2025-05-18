// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

// MARK: - Header Generator
func makeHeader(fileName: String, moduleName: String, author: String, date: String, company: String, year: String = "2025") -> String {
    return """
//
// \(fileName).swift
// \(company)
//
// Created by \(author) on \(date).
// Copyright © \(year) GenIT. All rights reserved.
//

"""
}

// MARK: - Helper
func createFolderIfNeeded(at path: String) {
    if !FileManager.default.fileExists(atPath: path) {
        try! FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true)
    }
}

func writeFile(at path: String, content: String) {
    FileManager.default.createFile(atPath: path, contents: content.data(using: .utf8))
}

enum Template: String {
    case viewController = "ViewController.template.swift"
    case viewModel = "ViewModel.template.swift"
}

func renderTemplate(named template: Template, replacements: [String: String]) -> String {
    let path = FileManager.default.currentDirectoryPath + "/Templates/\(template.rawValue)"
    guard let raw = try? String(contentsOfFile: path) else {
        return "// Error: no se pudo cargar el template \(template.rawValue)"
    }
    
    return replacements.reduce(raw) { result, pair in
        result.replacingOccurrences(of: "{{\(pair.key)}}", with: pair.value)
    }
}

// MARK: - Entrada CLI
let args = CommandLine.arguments

guard args.count >= 3 else {
    print("❌ Uso: swift run <tool> <Modulo> <NombrePantalla> [--viewmodel] [--company <Empresa>]")
    exit(1)
}

var company = "AL2Wallet"
if let companyFlagIndex = args.firstIndex(of: "--company"), companyFlagIndex + 1 < args.count {
    company = args[companyFlagIndex + 1]
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
func generateViewController(screenName: String, moduleName: String, folderPath: String, company: String) {
    let fileName = "\(screenName)ViewController"
    let author = NSFullUserName()
    let date = DateFormatter.localizedString(from: Date(), dateStyle: .short, timeStyle: .none)
    let header = makeHeader(fileName: fileName, moduleName: moduleName, author: author, date: date, company: company)
    let body = renderTemplate(named: .viewController, replacements: [
        "ModuleName": moduleName,
        "ScreenName": screenName,
        "FileName": fileName
    ])
    let content = header + body
    let path = "\(folderPath)/\(fileName).swift"
    writeFile(at: path, content: content)
}

func generateViewModel(screenName: String, moduleName: String, folderPath: String, company: String) {
    let fileName = "\(screenName)ViewModel"
    let author = NSFullUserName()
    let date = DateFormatter.localizedString(from: Date(), dateStyle: .short, timeStyle: .none)
    let header = makeHeader(fileName: fileName, moduleName: moduleName, author: author, date: date, company: company)
    let body = renderTemplate(named: .viewModel, replacements: [
        "ModuleName": moduleName,
        "ScreenName": screenName,
        "FileName": fileName
    ])
    let content = header + body
    let path = "\(folderPath)/\(fileName).swift"
    writeFile(at: path, content: content)
}

generateViewController(screenName: screenName, moduleName: moduleName, folderPath: viewFolder, company: company)

if includeViewModel {
    generateViewModel(screenName: screenName, moduleName: moduleName, folderPath: viewModelFolder, company: company)
}

print("✅ Se generó el módulo \(moduleName)/ con la pantalla \(screenName).")
if includeViewModel {
    print("Se incluyó ViewModel también.")
}
