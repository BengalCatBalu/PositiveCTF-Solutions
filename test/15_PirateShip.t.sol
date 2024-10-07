// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

import "./BaseTest.t.sol";
import "src/15_PirateShip/PirateShip.sol";
import {console} from "forge-std/console.sol";


// forge test --match-contract PirateShipTest -vvvv
contract PirateShipTest is BaseTest {
    PirateShip instance;

    function setUp() public override {
        super.setUp();
        instance = new PirateShip();
        instance.dropAnchor(block.number + 100001);
        vm.roll(824);

        uint256 blockNumber = block.number + 100_000 + 1;
        instance.dropAnchor(blockNumber);
        vm.roll(block.number + 100_000 + 1);
        instance.pullAnchor();
    }

    function testExploitLevel() public {
        // /* YOUR EXPLOIT GOES HERE */
        instance.sailAway();
        checkSuccess();
    }

    function checkSuccess() internal view override {
        assertTrue(instance.blackJackIsHauled() == true, "Solution is not solving the level");
    }
}
