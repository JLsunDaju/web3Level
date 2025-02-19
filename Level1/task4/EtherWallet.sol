// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.17;

contract EtherWallet  {


    address payable public immutable owner;
    event Log(string funcName,address from,uint256 amountt,bytes data);
    constructor(){
        owner = payable(msg.sender);
    }

    receive() external payable {
        emit Log("receive",msg.sender,msg.value,"");
    }

    // 取钱方式1
    function withDraw1() external{
        require(msg.sender == owner,"not owner");
        payable(owner).transfer(100);
    }

    // 取钱方式2
    function withDraw2() external{
        require(msg.sender == owner,"not owner");
        // send会返回是否转账成功，并不会自己处理异常
        // 所以咱们在后面使用require处理
        bool success = payable(owner).send(100);
        require(success,"send Failed");
    }
    // 取钱方式3
    function withDraw3() external{
        require(msg.sender == owner,"not owner");
        (bool success,) = msg.sender.call{value: address(this).balance}("");
        require(success,"call failed");
    }


}