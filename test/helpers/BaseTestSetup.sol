// SPDX-License-Identifier: MIT
pragma solidity 0.8.21;

import {ERC20PresetMinterPauser} from "./ERC20PresetMinterPauser.sol";
import {WETH_ADDRESS} from "../../src/Constants.sol";
import {Create2} from "@openzeppelin/contracts/utils/Create2.sol";

import {Test} from "forge-std/Test.sol";
import {VmSafe as Vm} from "forge-std/Vm.sol";
import "forge-std/console.sol";

abstract contract BaseTestSetup is Test {
    modifier prankAgnostic() {
        (Vm.CallerMode mode, address msgSender, ) = vm.readCallers();
        if (
            mode == Vm.CallerMode.Prank || mode == Vm.CallerMode.RecurrentPrank
        ) {
            vm.stopPrank();
        }
        _;
        if (mode == Vm.CallerMode.Prank) {
            vm.prank(msgSender);
        } else if (mode == Vm.CallerMode.RecurrentPrank) {
            vm.startPrank(msgSender);
        }
    }

    ERC20PresetMinterPauser underlying;
    address internal TREASURY = vm.addr(2);
    uint8 internal constant DECIMALS = 18;
    string internal constant SYMBOL = "iWETH";
    string internal constant NAME = "Ion Wrapped Ether";

    // @audit etch cheatcode is unavailable in HEVM
    function setUp() public virtual {
        // @audit deployment of this contract seems to be deterministic to 0x5991A2dF15A8F6A256D3Ec51E99254Cd3fb576A9 address
        // using this to set the WETH_ADDRESS in Constants since etch cheatcode can't be used
        underlying = new ERC20PresetMinterPauser("WETH", "Wrapped Ether");
        underlying.grantRole(underlying.MINTER_ROLE(), address(this));
        underlying.grantRole(underlying.DEFAULT_ADMIN_ROLE(), address(this));

        // --------------- previous implementation ---------------

        // if (address(WETH_ADDRESS).code.length == 0) {
        //     vm.etch(address(WETH_ADDRESS), address(underlying).code);
        //     wraps the WETH_ADDRESS in ERC20PresetMinterPauser interface
        //     underlying = ERC20PresetMinterPauser(address(WETH_ADDRESS));
        //     underlying.grantRole(underlying.MINTER_ROLE(), address(this));
        //     underlying.grantRole(
        //         underlying.DEFAULT_ADMIN_ROLE(),
        //         address(this)
        //     );
        // }
    }

    function computeAddress(
        bytes32 salt,
        bytes32 bytecodeHash
    ) public view returns (address) {
        return Create2.computeAddress(salt, bytecodeHash, address(this));
    }
}
