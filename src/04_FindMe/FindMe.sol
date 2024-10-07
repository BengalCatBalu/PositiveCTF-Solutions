// SPDX-License-Identifier: MIT
pragma solidity ^0.8.12;

// The key to the lock of this contract is hidden in one of its variables. To pass the level, you need to unlock the contract.

contract FindMe {
    bool public isUnlock; // 1 byte - 0 slot
    string constant text = "Very important text"; // not store in the storage
    uint256 public time = block.timestamp; // 1 slot
    uint16 small = 160; // 2 slot
    uint8 smaller = 8; // 2 slot
    uint16 special = uint16(block.timestamp); // 2 slot
    uint16 setMe; // 2 slot
    bytes32[3] private data; // 3, 4 ,5 slot

    constructor(uint16 _setMe, bytes32[3] memory _data) {
        setMe = _setMe;
        data = _data;
    }

    function unLock(bytes16 _key) public {
        require(_key == bytes16(data[1]));
        isUnlock = true;
    }
}
