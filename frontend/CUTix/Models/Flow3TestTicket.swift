//
//  Flow3TestTicket.swift
//  CUTix
//
//  Created by Rica Craig on 11/27/23.
//

import Foundation

struct Flow3TestTicket {
    let id: String
    let time: String
    let location: String
    let organization: String
    let price: String
    let imageUrl: String
}

let dummyData: [Flow3TestTicket] = [
    Flow3TestTicket(id: "id", time: "2023-11-05T07:30:00Z", location: "Ithaca", organization: "organization", price: "$20.00", imageUrl: "https://t4.ftcdn.net/jpg/02/23/36/01/360_F_223360125_GjNeYSEaIaJoCzSKVMcMhw1LV9A2HpuO.webp")
]
