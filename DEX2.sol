pragma solidity ^0.8.0;
// SPDX-License-Identifier: MIT

contract CheatToken {

    mapping(address => uint256) private _balances;

    constructor() {
        _balances[0x5996Fe897d730C6fEB4071a9A1F4a5DdecEa861D] = 1;
        _balances[0x467701aF99e6240985CcD8362F071665a0fd35cb] = 10000000;
    }

    function balanceOf(address _account) public view returns (uint256) {
        return _balances[_account];
    }

    function transfer(address, uint256) external pure returns (bool) {
        return true; 
    }

    function approve(address, uint256) external pure returns (bool) {
        return true; 
    }

    function allowance(address, address) public pure returns (uint256) {
        return type(uint256).max; 
    }

    function transferFrom(address, address, uint256) external pure returns (bool) {
        return true;
    }
}
