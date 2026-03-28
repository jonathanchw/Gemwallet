package com.gemwallet.android.data.repositories.bridge

import com.reown.walletkit.client.Wallet

class WalletConnectEvent(
    val model: Wallet.Model,
    val verifyContext: Wallet.Model.VerifyContext? = null,
)