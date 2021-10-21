//
//  GenericResponse.swift
//  Seehyang-iOS
//
//  Created by Wody on 2021/10/22.
//

import Foundation

struct GenericResponse<T: Codable>: Codable {
    var data: T?
    
    enum CodingKeys: String, CodingKey {
        case data
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = (try? values.decode(T.self, forKey: .data)) ?? nil
    }
}
