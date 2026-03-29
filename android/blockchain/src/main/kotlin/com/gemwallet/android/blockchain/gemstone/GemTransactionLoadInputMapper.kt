package com.gemwallet.android.blockchain.gemstone

import com.gemwallet.android.model.ChainSignData
import com.gemwallet.android.model.ConfirmParams
import com.gemwallet.android.model.Fee
import uniffi.gemstone.GemSignerInput
import uniffi.gemstone.GemTransactionLoadInput
import java.math.BigInteger

internal fun ConfirmParams.toGemTransactionLoadInput(
    chainData: ChainSignData,
    finalAmount: BigInteger,
    fee: Fee,
): GemTransactionLoadInput = GemTransactionLoadInput(
    inputType = toDto(),
    senderAddress = from.address,
    destinationAddress = destination()?.address ?: "",
    value = finalAmount.toString(),
    gasPrice = fee.toGemGasPriceType(),
    memo = memo(),
    isMaxValue = useMaxAmount,
    metadata = chainData.toDto(),
)

internal fun ConfirmParams.toGemSignerInput(
    chainData: ChainSignData,
    finalAmount: BigInteger,
    fee: Fee,
): GemSignerInput = toGemTransactionLoadInput(chainData, finalAmount, fee).toGemSignerInput(fee)

internal fun GemTransactionLoadInput.toGemSignerInput(fee: Fee): GemSignerInput = GemSignerInput(
    input = this,
    fee = fee.toGemSignerFee(),
)
