//
//  File.swift
//  yuna_endproject
//
//  Created by user05 on 2023/12/10.
//

import CryptoKit
import Foundation

let ts = Date().timeIntervalSinceReferenceDate
let privateKey = "56fa084d1584339da5cbf3397850b047c7d2110a"
let publicKey = "17f12e4f39c817a8dd2444fc7c46dec7"
let md5InputData = "\(ts)\(privateKey)\(publicKey)".data(using: .utf8)!
let digest = Insecure.MD5.hash(data: md5InputData)
let hashString = digest.map {
    String(format: "%02x", $0)
}.joined()
