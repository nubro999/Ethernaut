// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Noreceive {
    address target;

    constructor(address _target) payable  {
        target = _target;
    }

    function sendmoney() external payable {
        target.call{value: msg.value}("");
    }
}