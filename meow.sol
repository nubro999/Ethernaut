// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IForce {
}

contract Reentrancy {

    IForce target;

    constructor() {
        target = IForce(0xF91ACE32d1597dea77D2b5cC82587159ED50332f);
    }

    function force() public payable {
        (bool success, ) = address(target).call{value: msg.value}("");
        require(success, "Transfer failed");
    }
}