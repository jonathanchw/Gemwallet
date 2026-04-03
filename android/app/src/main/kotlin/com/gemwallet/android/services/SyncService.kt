package com.gemwallet.android.services

import com.gemwallet.android.application.transactions.coordinators.SyncTransactions
import com.gemwallet.android.cases.device.SyncDeviceInfo
import com.gemwallet.android.data.repositories.buy.BuyRepository
import com.gemwallet.android.data.repositories.session.SessionRepository
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.async
import kotlinx.coroutines.awaitAll
import kotlinx.coroutines.flow.firstOrNull
import kotlinx.coroutines.withContext
import javax.inject.Inject

class SyncService @Inject constructor(
    private val sessionRepository: SessionRepository,
    private val syncTransactions: SyncTransactions,
    private val buyRepository: BuyRepository,
    private val syncDeviceInfo: SyncDeviceInfo,
) {

    suspend fun sync() = withContext(Dispatchers.IO) {
        val wallet = sessionRepository.session().firstOrNull()?.wallet
        buildList {
            add(async { buyRepository.sync() })
            wallet?.let { wallet ->
                add(async { syncTransactions.syncTransactions(wallet) })
            }
        }
            .awaitAll()
        syncDeviceInfo.syncDeviceInfo()
    }
}
