//
//  Company.swift
//  Analytics Page
//
//  Created by Nguyên Trần on 03/07/2022.
//

import SwiftUI

struct Company: Identifiable {
    var id: String = UUID().uuidString
    var name: String
    var avatar: String
    var color: String
    var price: Int
}

let _companies: [Company] = [
    Company(name: "Dibbble", avatar: "dribbble", color: "DribbbleColor", price: 26),
    Company(name: "Google", avatar: "google", color: "GoogleColor", price: 60),
    Company(name: "Tik Tok", avatar: "tiktok", color: "TikTokColor", price: 40)

]
