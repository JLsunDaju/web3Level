 // SPDX-License-Identifier: MIT
 pragma solidity >= 0.8.26;

//  import "@openzeppelin/contracts/ERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";

// 初始化地址1000代币   0x5B38Da6a701c568545dCfcB03FcB875f56beddC4
// 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2   分她200代币
// 0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db
contract MyToken is ERC20 {
    constructor(string memory name_,string memory symbol_) ERC20(name_,symbol_) {
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
