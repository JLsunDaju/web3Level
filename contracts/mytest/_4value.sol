
// 变量作用域
// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;
// 使用for循环计算1到n的所有奇数和，并使用try/catch结构处理外部合约调用中的异常。
contract SumAll {
    function addAll() public pure  returns(uint){
        uint osum = 0;
        for (uint i = 0 ; i < 10; i++) 
        {
            if(i % 2 != 0) osum += i;
        }
        return (osum);
    }
    function getAddress() public view returns (address) {
        return msg.sender;
    }
}
contract useSumAll {
    function usefunc(address _addr) public  pure  returns (uint osum) {
        SumAll sumAllContract = SumAll(_addr);

        try sumAllContract.addAll() returns (uint result) {
            osum = result; // 成功时返回结果
        } catch {
            osum = 0; // 失败时返回默认值0
        }
        
        return osum;
        // try sumAll(_addr).addAll()  returns(uint dd){
        //     osum = dd;
        //     return osum;
        // } catch {
        // }
    }
}