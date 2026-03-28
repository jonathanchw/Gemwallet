package com.gemwallet.android.features.earn.delegation.models

sealed interface DelegationActions {
    object WithdrawalAction : DelegationActions

    object StakeAction : DelegationActions

    object UnstakeAction : DelegationActions

    object RedelegateAction : DelegationActions
}