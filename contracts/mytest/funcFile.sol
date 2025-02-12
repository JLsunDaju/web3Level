// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract FuncFile {

    bytes4 public storedSelector;

    function square(uint x) public pure returns (uint){
        return x * x;
    }

    function double(uint x) public pure returns (uint){
        return x * 2;
    }

    function getSelectorSquare() external pure returns (bytes4){
        return this.square.selector;
    }

    function getSelectorDouble() external pure returns (bytes4){
        return this.double.selector;
    }

    function executeFunction(bytes4 selector, uint x) external returns (uint z){
        (bool success,bytes memory data) = address(this).call(abi.encodeWithSelector(selector, x));
        require(success,'Call failed');
        z = abi.decode(data,(uint));
    }

    // 函数：存储选择器到状态变量 storedSelector 中
    function storeSelector(bytes4 selector) public {
        storedSelector = selector;
    }

    function executeStoredFunction(uint x) external returns (uint){
        // 是否选中函数选择器
        require(storedSelector != bytes4(0), "Selector not set");
        (bool success,bytes memory data) = address(this).call(abi.encodeWithSelector(storedSelector, x));
        require(success,'Call failed');
        return abi.decode(data,(uint));
    }
}