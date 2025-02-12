

// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;


error ErrorError(string reason);
contract OnlyEven{
    constructor(uint a){
        require(a != 0, "invalid number");
        assert(a != 1);
    }

    function onlyEven(uint256 b) external pure returns(bool success){
        // 输入奇数时revert
        require(b != 2, "Ups! Reverting");
        assert(b != 3);
        if(b == 4)
            revert("not equal 4");
        if(b == 5 )
            revert ErrorError("not equal 5");
        success = true;
    }
}

contract TryCatch {
    // 成功event
    event SuccessEvent();
    // 失败event
    event CatchEvent(string message);
    event CatchByte(bytes data);
    // 声明OnlyEven合约变量
    OnlyEven even;
    constructor() {
        even = new OnlyEven(2);
    }
    // 在external call中使用try-catch
    function execute(uint amount) external returns (bool success) {
        try even.onlyEven(amount) returns(bool _success){
            // call成功的情况下
            emit SuccessEvent();
            return _success;
        } catch Error(string memory reason){
            // call不成功的情况下
            // 0xb761112a  
            // require(bool,reason) revert("reason")
            emit CatchEvent(reason);
        } catch (bytes memory reason){
            // 0xb6f66868  assert(bool) 
            emit CatchByte(reason);
        }
    }
}
