


// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

// 编写一个库 MathLib，实现加法、减法和乘法函数，并在合约中使用该库。
library MathLib {
    function add(uint a,uint b) public pure returns (uint){
        return a + b;
    }
    function reduce(uint a,uint b) public pure returns (uint){
        require(a >= b,"a xiao");
        return a - b;
    }
}
contract AddTest2 {
    function add(uint x, uint y) public pure returns (uint) {
        return MathLib.add(x, y);
    }
    function reduce(uint x, uint y) public pure returns (uint) {
        return MathLib.reduce(x, y);
    }
}

// library SafeMath {
//     function add(uint a, uint b) internal pure returns (uint) {
//         uint c = a + b;
//         require(c >= a, "SafeMath: addition overflow");
//         return c;
//     }
// }
// 使用 SafeMath 库的合约
contract AddTest {
    function add(uint x, uint y) public pure returns (uint) {
        // return SafeMath.add(x, y);
    }
}