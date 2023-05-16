//
//  MainModel.swift
//  iOSExample
//
//  Created by dongju.lim on 2023/02/13.
//

import Foundation

final class MainModelModel: Decodable {

    private enum CodingKeys: String, CodingKey {
        case KEYS
    }

    required init(from decoder: Decoder) throws {
//        guard let container = try? decoder.container(keyedBy: CodingKeys.self) else { return }
    }
}
