// Copyright (c). Gem Wallet. All rights reserved.

import Foundation
import enum GemstonePrimitives.GemstoneConfig
import enum Primitives.Chain

public struct StakeRecommendedValidators {
    private var list: [Chain: Set<String>] {
        var output: [Chain: Set<String>] = [:]
        for (key, values) in GemstoneConfig.shared.getValidators() {
            if let chain = Chain(rawValue: key) {
                output[chain] = Set(values)
            }
        }
        return output
    }

    public init() {}

    public func randomValidatorId(chain: Chain) -> String? {
        list[chain]?.randomElement()
    }

    public func validatorsSet(chain: Chain) -> Set<String> {
        list[chain] ?? Set()
    }
}
