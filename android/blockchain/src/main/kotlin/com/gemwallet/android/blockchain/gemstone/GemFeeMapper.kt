package com.gemwallet.android.blockchain.gemstone

import com.gemwallet.android.model.Fee
import uniffi.gemstone.FeeOption as GemFeeOption
import uniffi.gemstone.GemFeeOptions
import uniffi.gemstone.GemGasPriceType
import uniffi.gemstone.GemTransactionLoadFee

internal fun Fee.toGemGasPriceType(): GemGasPriceType = when (this) {
    is Fee.Eip1559 -> GemGasPriceType.Eip1559(
        gasPrice = maxGasPrice.toString(),
        priorityFee = minerFee.toString(),
    )
    is Fee.Plain -> GemGasPriceType.Regular(
        gasPrice = amount.toString(),
    )
    is Fee.Regular -> GemGasPriceType.Regular(
        gasPrice = maxGasPrice.toString(),
    )
    is Fee.Solana -> GemGasPriceType.Solana(
        gasPrice = maxGasPrice.toString(),
        priorityFee = minerFee.toString(),
        unitPrice = unitFee.toString(),
    )
}

internal fun Fee.toGemSignerFee(): GemTransactionLoadFee = GemTransactionLoadFee(
    fee = amount.toString(),
    gasPriceType = toGemGasPriceType(),
    gasLimit = when (this) {
        is Fee.Eip1559 -> limit.toString()
        is Fee.Regular -> limit.toString()
        is Fee.Solana -> limit.toString()
        is Fee.Plain -> "0"
    },
    options = GemFeeOptions(
        when (this) {
            is Fee.Plain -> options
            is Fee.Regular -> options
            is Fee.Eip1559 -> options
            is Fee.Solana -> options
        }.mapNotNull { (key, value) ->
            runCatching { GemFeeOption.valueOf(key) }.getOrNull()?.let { option ->
                option to value.toString()
            }
        }.toMap()
    )
)
