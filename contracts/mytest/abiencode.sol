

// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

// contract AbiTest {


//     uint x = 10;
//     address addr = 0x7A58c0Be72BE218B41C608b7Fe7C5bB630736C71;
//     string name = "0xAA";
//     uint[2] array = [5, 6]; 

//     function encodeFunc() external view  returns (bytes memory){
//         return abi.encode(x,addr,name,array);
//     }
//     function encodePackedFunc() external view  returns (bytes memory){
//         return abi.encodePacked(x,addr,name,array);
//     }
//     function encodeWithSignatureFunc(address _addr,uint _x) external returns (uint) {
        
//         // encodeWithSignature第一个参数是函数签名  函数签名就是函数名加上形参类型的字符串
//         (bool success, bytes memory data) = _addr.call(abi.encodeWithSignature("setX(uint256)", _x));


//         require(success);
//         (uint256 x) = abi.decode(data,(uint256));
//         return  x;
//         // return abi.encodeWithSignature((),x);
//     }

//     function Func(address _addr,uint _x) external returns (uint) {
//         // encodeWithSelector 第一个参数是函数选择器  选择器的类型是bytes4 
//         // 获取函数选择器有两种方式
//         bytes4 selector = B.setX.selector;
//         bytes4 sleecor2 = bytes4(keccak256("setX(uint256)"));


//         // 使用call方法调用的其他合约的函数返回值，会保存在bytes里面。里面的数据是加密的，需要使用decode解密
//         (bool success, bytes memory data) = _addr.call(abi.encodeWithSelector(selector, _x));

//         (bool success1, bytes memory data1) = _addr.call(abi.encodeWithSelector(sleecor2, _x));
//         require(success);
//         // 解密统一写成abi.decode(待解密数据,待解密数据的数据类型(uint256,string))  这种写法
//         // 注意这里的解密类型有几个前面接收参数就有几个类型，你可以不写但是必须空出来。(uint x, , uint y)这种样式一共三个参数，取第一个和第三个
//         (uint256 x) = abi.decode(data,(uint256));
//         (uint256 x1) = abi.decode(data1,(uint256));
//         return  x;
//         // return abi.encodeWithSignature((),x);
//     }

// }

contract B {
    uint public x = 10;

    function setX(uint _x) external returns (uint){
        x = _x;
        return x+1;
    }

    function ke() external pure  returns (bytes4){
        return bytes4(keccak256("transfer(address sender, uint256 amount)"));
    }
}