// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract myContract {
  address public owner;
  
  constructor() public{
    owner = msg.sender;
  }

  receive() external payable{}
  

  function destroy(address payable meew) public {
    selfdestruct(meew);
  }
}