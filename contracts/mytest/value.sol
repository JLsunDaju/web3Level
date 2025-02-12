// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

// 练习：实现一个简单的存款和取款合约
contract SimpleWallet {


    function getAddress() public view returns (address) {
        return address(this);  // 返回当前合约的地址
    }
    mapping(address => uint256) public balances;

    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw(uint256 amount) public {
        require(balances[msg.sender] >= amount, "Insufficient balance.");
        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
    }

    function checkBalance() public view returns (uint256) {
        return balances[msg.sender];
    }
}

