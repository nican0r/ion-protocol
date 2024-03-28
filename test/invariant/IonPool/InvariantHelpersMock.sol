// SPDX-License-Identifier: MIT
pragma solidity 0.8.21;

import {IonPool} from "../../../src/IonPool.sol";
import {InvariantHelpers} from "../../helpers/InvariantHelpers.sol";

contract InvariantHelpersMock {
    // public wrapper for getUtilizationRate to be able to catch reverts
    function getUtilizationRate(
        IonPool ionPool
    ) public view returns (uint256 utilizationRate) {
        utilizationRate = InvariantHelpers.getUtilizationRate(ionPool);
    }
}
