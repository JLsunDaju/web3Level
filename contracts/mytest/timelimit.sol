
// 每天操作一次

// SPDX-License-Identifier: MIT
pragma solidity >=0.8.26;

contract TimeLimit {

    uint public lastUpdateTime;
    address public owner;

    constructor (){
        owner = msg.sender;

        lastUpdateTime = block.timestamp - 1 days;

    }


    function performAction(address _addr) public {
        require(_addr == owner,"Only owner can perform this action.");
        require(block.timestamp >= lastUpdateTime + 1 days,"You can only perform this action once per day.");
        lastUpdateTime = block.timestamp;
    }


}