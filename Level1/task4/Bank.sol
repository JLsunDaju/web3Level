// SPDX-License-Identifier: MIT
 pragma solidity ^0.8.17;

contract Bank {
    // 状态变量

    address public immutable owner;

    // 定义事件
    event Deposit(address _ads,uint256 amount);
    event Withdraw(uint256 amount);

    receive() external payable {
        emit Deposit(msg.sender, msg.value);
    }
    // 构造函数
    constructor() payable {
        owner = msg.sender;
    }
    function withdraw() external {
        require(msg.sender == owner,"not owner");
        emit Withdraw(address(this).balance);
        // selfdestruct的参数是一个payable的地址
        // 当执行selfdestruct时，会将合约账户的所有余额转移到指定地址。并销毁合约
        selfdestruct(payable(msg.sender));
    }


    function getbalance() external view returns (uint256) {
        return address(this).balance;
    }

}