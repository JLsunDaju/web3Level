

// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract ModifyTest {

    address public owner;

    modifier onlyOwner {
        // 
        require(msg.sender == owner,"not owner");
        _;
    }

    constructor (){
        owner = msg.sender;
    }


    function change(address _addr) external onlyOwner {
        owner = _addr;
    }




}