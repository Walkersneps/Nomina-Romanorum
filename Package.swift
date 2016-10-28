//
//  Package.swift
//  Nomina-Romanorum
//
//  Created by Walter Carli on 28/10/16.
//
//
import PackageDescription

let package = Package(
	name: "Nomina-Romanorum",
	targets: [],
	dependencies: [
		.Package(url: "https://github.com/PerfectlySoft/Perfect-HTTPServer.git", majorVersion: 2, minor: 0)
    ]
)
