// SPDX-License-Identifier: MIT
pragma solidity 0.8.21;

import {IonPool_InvariantTest} from "./ActorManagerUpdated.t.sol";
import {CryticAsserts} from "@chimera/CryticAsserts.sol";

// run echidna: echidna test/invariant/IonPool/IonPoolEchidna.sol --contract IonPool_Echidna --config echidna-config.yaml
contract IonPool_Echidna is IonPool_InvariantTest, CryticAsserts {
    constructor() {
        _setUp(false, false);
    }

    function fuzzedFallback(
        uint128 userIndex,
        uint128 ilkIndex,
        uint128 amount,
        uint128 warpTimeAmount,
        uint256 functionIndex
    ) public {
        try
            actorManager.fuzzedFallback(
                userIndex,
                ilkIndex,
                amount,
                warpTimeAmount,
                functionIndex
            )
        {} catch {
            t(false, "fuzzedFallback reverts in Echidna contract");
        }
    }

    // need to setup fuzzedFallback here to test like they're expecting
    // function supply(
    //     uint8 index,
    //     uint88 amount,
    //     uint48 warpTimeAmount
    // ) external {
    //     actorManager.supply(index, amount, warpTimeAmount);
    // }

    // function withdraw(
    //     uint8 index,
    //     uint88 amount,
    //     uint48 warpTimeAmount
    // ) external {
    //     actorManager.withdraw(index, amount, warpTimeAmount);
    // }

    // function borrow(
    //     uint8 borrowerIndex,
    //     uint8 ilkIndex,
    //     uint128 amount,
    //     uint48 warpTimeAmount
    // ) external {
    //     actorManager.borrow(borrowerIndex, ilkIndex, amount, warpTimeAmount);
    // }

    // function repay(
    //     uint8 borrowerIndex,
    //     uint8 ilkIndex,
    //     uint128 amount,
    //     uint48 warpTimeAmount
    // ) external {
    //     actorManager.repay(borrowerIndex, ilkIndex, amount, warpTimeAmount);
    // }

    // function depositCollateral(
    //     uint8 borrowerIndex,
    //     uint8 ilkIndex,
    //     uint128 amount,
    //     uint48 warpTimeAmount
    // ) external {
    //     actorManager.depositCollateral(
    //         borrowerIndex,
    //         ilkIndex,
    //         amount,
    //         warpTimeAmount
    //     );
    // }

    // function withdrawCollateral(
    //     uint8 borrowerIndex,
    //     uint8 ilkIndex,
    //     uint128 amount,
    //     uint48 warpTimeAmount
    // ) external {
    //     actorManager.withdrawCollateral(
    //         borrowerIndex,
    //         ilkIndex,
    //         amount,
    //         warpTimeAmount
    //     );
    // }

    // function gemJoin(
    //     uint8 borrowerIndex,
    //     uint8 ilkIndex,
    //     uint128 amount,
    //     uint48 warpTimeAmount
    // ) external {
    //     actorManager.gemJoin(borrowerIndex, ilkIndex, amount, warpTimeAmount);
    // }

    // function gemExit(
    //     uint8 borrowerIndex,
    //     uint8 ilkIndex,
    //     uint128 amount,
    //     uint48 warpTimeAmount
    // ) external {
    //     actorManager.gemExit(borrowerIndex, ilkIndex, amount, warpTimeAmount);
    // }
}
