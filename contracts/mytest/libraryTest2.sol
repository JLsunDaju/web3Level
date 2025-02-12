
// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;
import './libraryTest.sol';
contract LibraryTest2 {


    function testLibrary(uint a,uint b) public pure  returns (uint){
        return    MathLib.add(a,b);
    }

}