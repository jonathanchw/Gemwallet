package com.gemwallet.android.features.earn.delegation.models

sealed interface DelegationBalances {
    class Stake(val data: String) : DelegationBalances

    class Rewards(val data: String) : DelegationBalances
}