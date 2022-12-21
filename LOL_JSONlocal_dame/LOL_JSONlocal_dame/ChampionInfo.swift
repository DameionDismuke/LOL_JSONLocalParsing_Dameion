//
//  ChampionInfo.swift
//  LOL_JSONlocal_dame
//
//  Created by Dameion Dismuke on 12/21/22.
//

import Foundation


struct Result: Codable{
    let data: [ChampProfile]
}

struct ChampProfile: Codable{
    let desc: String
    let id: Int
    let name: String
    let tags: [String]
    
}

