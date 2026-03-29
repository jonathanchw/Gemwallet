// Copyright (c). Gem Wallet. All rights reserved.

import Gemstone
import Primitives

public extension GemTransactionLoadMetadata {
    func map() throws -> TransactionLoadMetadata {
        switch self {
        case .none:
            return .none
        case let .solana(senderTokenAddress, recipientTokenAddress, tokenProgram, blockHash):
            return .solana(
                senderTokenAddress: senderTokenAddress,
                recipientTokenAddress: recipientTokenAddress,
                tokenProgram: tokenProgram?.map(),
                blockHash: blockHash
            )
        case let .ton(senderTokenAddress, recipientTokenAddress, sequence):
            return .ton(
                senderTokenAddress: senderTokenAddress,
                recipientTokenAddress: recipientTokenAddress,
                sequence: sequence
            )
        case let .cosmos(accountNumber, sequence, chainId):
            return .cosmos(accountNumber: UInt64(accountNumber), sequence: sequence, chainId: chainId)
        case let .bitcoin(utxos):
            return try .bitcoin(utxos: utxos.map { try $0.map() })
        case let .zcash(utxos, branchId):
            return try .zcash(utxos: utxos.map { try $0.map() }, branchId: branchId)
        case let .cardano(utxos):
            return try .cardano(utxos: utxos.map { try $0.map() })
        case let .evm(nonce, chainId, contractCall):
            return .evm(nonce: UInt64(nonce), chainId: UInt64(chainId), contractCall: contractCall?.map())
        case let .near(sequence, blockHash):
            return .near(sequence: sequence, blockHash: blockHash)
        case let .stellar(sequence, isDestinationAddressExist):
            return .stellar(sequence: sequence, isDestinationAddressExist: isDestinationAddressExist)
        case let .xrp(sequence, blockNumber):
            return .xrp(sequence: sequence, blockNumber: blockNumber)
        case let .algorand(sequence, blockHash, chainId):
            return .algorand(sequence: sequence, blockHash: blockHash, chainId: chainId)
        case let .aptos(sequence, data):
            return .aptos(sequence: sequence, data: data)
        case let .polkadot(sequence, genesisHash, blockHash, blockNumber, specVersion, transactionVersion, period):
            return .polkadot(
                sequence: sequence,
                genesisHash: genesisHash,
                blockHash: blockHash,
                blockNumber: UInt64(blockNumber),
                specVersion: specVersion,
                transactionVersion: transactionVersion,
                period: UInt64(period)
            )
        case let .tron(
            blockNumber,
            blockVersion,
            blockTimestamp,
            transactionTreeRoot,
            parentHash,
            witnessAddress,
            stakeData
        ):
            return .tron(
                blockNumber: UInt64(blockNumber),
                blockVersion: UInt64(blockVersion),
                blockTimestamp: UInt64(blockTimestamp),
                transactionTreeRoot: transactionTreeRoot,
                parentHash: parentHash,
                witnessAddress: witnessAddress,
                stakeData: stakeData.map()
            )
        case let .sui(messageBytes):
            return .sui(messageBytes: messageBytes)
        case let .hyperliquid(order):
            return .hyperliquid(order: order?.map())
        }
    }
}

public extension TransactionLoadMetadata {
    func map() -> GemTransactionLoadMetadata {
        switch self {
        case .none:
            return .none
        case let .solana(senderTokenAddress, recipientTokenAddress, tokenProgram, blockHash):
            return .solana(
                senderTokenAddress: senderTokenAddress,
                recipientTokenAddress: recipientTokenAddress,
                tokenProgram: tokenProgram?.map(),
                blockHash: blockHash
            )
        case let .ton(senderTokenAddress, recipientTokenAddress, sequence):
            return .ton(senderTokenAddress: senderTokenAddress, recipientTokenAddress: recipientTokenAddress, sequence: sequence)
        case let .cosmos(accountNumber, sequence, chainId):
            return .cosmos(accountNumber: UInt64(accountNumber), sequence: sequence, chainId: chainId)
        case let .bitcoin(utxos):
            return .bitcoin(utxos: utxos.map { $0.map() })
        case let .zcash(utxos, branchId):
            return .zcash(utxos: utxos.map { $0.map() }, branchId: branchId)
        case let .cardano(utxos):
            return .cardano(utxos: utxos.map { $0.map() })
        case let .evm(nonce, chainId, contractCall):
            return .evm(
                nonce: UInt64(nonce),
                chainId: UInt64(chainId),
                contractCall: contractCall?.map()
            )
        case let .near(sequence, blockHash):
            return .near(sequence: sequence, blockHash: blockHash)
        case let .stellar(sequence, isDestinationAddressExist):
            return .stellar(sequence: sequence, isDestinationAddressExist: isDestinationAddressExist)
        case let .xrp(sequence, blockNumber):
            return .xrp(sequence: sequence, blockNumber: blockNumber)
        case let .algorand(sequence, blockHash, chainId):
            return .algorand(sequence: sequence, blockHash: blockHash, chainId: chainId)
        case let .aptos(sequence, data):
            return .aptos(sequence: sequence, data: data)
        case let .polkadot(sequence, genesisHash, blockHash, blockNumber, specVersion, transactionVersion, period):
            return .polkadot(
                sequence: sequence,
                genesisHash: genesisHash,
                blockHash: blockHash,
                blockNumber: UInt64(blockNumber),
                specVersion: specVersion,
                transactionVersion: transactionVersion,
                period: UInt64(period)
            )
        case let .tron(
            blockNumber,
            blockVersion,
            blockTimestamp,
            transactionTreeRoot,
            parentHash,
            witnessAddress,
            stakeData
        ):
            return .tron(
                blockNumber: UInt64(blockNumber),
                blockVersion: UInt64(blockVersion),
                blockTimestamp: UInt64(blockTimestamp),
                transactionTreeRoot: transactionTreeRoot,
                parentHash: parentHash,
                witnessAddress: witnessAddress,
                stakeData: stakeData.map()
            )
        case let .sui(messageBytes):
            return .sui(messageBytes: messageBytes)
        case let .hyperliquid(order):
            return .hyperliquid(order: order?.map())
        }
    }
}

extension Gemstone.TronStakeData {
    func map() -> Primitives.TronStakeData {
        switch self {
        case let .votes(votes): .votes(votes.map { $0.map() })
        case let .unfreeze(amounts): .unfreeze(amounts.map { $0.map() })
        }
    }
}

extension Primitives.TronStakeData {
    func map() -> Gemstone.TronStakeData {
        switch self {
        case let .votes(votes): .votes(votes.map { $0.map() })
        case let .unfreeze(amounts): .unfreeze(amounts.map { $0.map() })
        }
    }
}

extension Gemstone.TronVote {
    func map() -> Primitives.TronVote {
        Primitives.TronVote(validator: validator, count: count)
    }
}

extension Primitives.TronVote {
    func map() -> Gemstone.TronVote {
        Gemstone.TronVote(validator: validator, count: count)
    }
}

extension Gemstone.TronUnfreeze {
    func map() -> Primitives.TronUnfreeze {
        Primitives.TronUnfreeze(resource: resource.map(), amount: amount)
    }
}

extension Primitives.TronUnfreeze {
    func map() -> Gemstone.TronUnfreeze {
        Gemstone.TronUnfreeze(resource: resource.map(), amount: amount)
    }
}

extension GemHyperliquidOrder {
    func map() -> HyperliquidOrder {
        HyperliquidOrder(
            approveAgentRequired: approveAgentRequired,
            approveReferralRequired: approveReferralRequired,
            approveBuilderRequired: approveBuilderRequired,
            builderFeeBps: UInt32(builderFeeBps),
            agentAddress: agentAddress,
            agentPrivateKey: agentPrivateKey
        )
    }
}

extension HyperliquidOrder {
    func map() -> GemHyperliquidOrder {
        GemHyperliquidOrder(
            approveAgentRequired: approveAgentRequired,
            approveReferralRequired: approveReferralRequired,
            approveBuilderRequired: approveBuilderRequired,
            builderFeeBps: builderFeeBps,
            agentAddress: agentAddress,
            agentPrivateKey: agentPrivateKey
        )
    }
}
