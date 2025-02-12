// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MyToken is ERC20 {
    constructor(string memory name,string memory symbol) ERC20(name,symbol) {
        _mint(msg.sender, 1000 * 10 ** 18);  // 给合约部署者 1000 代币
    }
    // 授权第三方可以使用代币
    function approveTokens(address spender, uint256 amount) public returns (bool) {
        return approve(spender, amount);  // 授权 spender 可以使用 amount 个代币
    }

    // 查询剩余的授权额度
    function checkAllowance(address owner, address spender) public view returns (uint256) {
        return allowance(owner, spender);  // 查询 owner 授权给 spender 的额度
    }

    // 第三方（被授权者）代替 owner 使用代币
    function transferFromOwner(address owner, address recipient, uint256 amount) public returns (bool) {
        return transferFrom(owner, recipient, amount);  // 代表 owner 将代币转移给 recipient
    }
}