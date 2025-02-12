// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

// contract TransferTest {


//     event Receive(uint amount);

//     receive() external payable { 
//         emit Receive(msg.value);
//     }

// }

// contract SendEnther {


// // 初始化时给初始金币
//     constructor() payable {}

//     // 
//     function TransferAmt() external {
//         payable(msg.sender).transfer(1 ether); 
//     }
//     // 
//     function sendAmt() external payable {
//         bool success = payable(msg.sender).send(1 ether); 
//         require(success);
        
//     }
//     // 
//     function callAmt() external payable {
//         (bool success,) = payable(msg.sender).call{value: 1 ether}(""); 
//         require(success);
//     }
//         // 返回合约ETH余额
//     function getBalance() view public returns(uint) {
//         return address(this).balance;
//     }
// }

contract CallTest {
    uint256 private x;
    event Log(uint amount,uint gas);
    event Message(string msg);

    receive() external payable { }
    fallback() external payable {
        emit Message("not right");
    }
    // 读取x
    function getX() external view  returns (uint256 _x){
        _x = x;
    }
    function getBalance() external view returns (uint){
        return address(this).balance;
    }

    function setX(uint _x) external payable {
        x = _x;
        if(msg.value > 0){
            emit Log(msg.value,gasleft());
        }
    }
}

contract CallContractTest {

    event Log(bytes b);


    function setCallX(uint x,address _address) external  {
        // 后面的调用方法要补齐256.
        (bool success,bytes memory data) = _address.call(abi.encodeWithSignature("setX(uint256)", x));
        require(success);
        emit Log(data);
    }

    function getCallX(address _address) external  {
        (bool success,bytes memory data) = _address.call(abi.encodeWithSignature("getX()"));
        require(success);
        emit Log(data);
    }

        function noFuncCallX(address _address) external  {
        (bool success,bytes memory data) = _address.call(abi.encodeWithSignature("foo()"));
        require(success);
        emit Log(data);
    }

}