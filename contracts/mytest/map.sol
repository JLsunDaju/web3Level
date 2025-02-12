// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

/*
任务 1：基于映射创建一个简单的用户余额管理系统，并实现余额的增加与查询功能。
任务 2：扩展系统，使其能够记录每个用户的交易历史，模拟 Java 的 Map 中键集合的概念。
任务 3：结合映射与数组，实现一个简单的排行榜系统，记录并排序用户的积分。
*/

contract PointsSystem {
    mapping(address => uint) public points;
    address[] public users;

    // 新增用户给默认积分
    function addUser(address _userAddr) public  returns (uint){
        require(points[_userAddr] == 0,"exit accout" );
        points[_userAddr] = 100;
        users.push(_userAddr);
        return points[_userAddr];
    }

    // 转账函数入参（收款账户地址，金额）

    function transferAmt(address _to,uint amt) public returns (uint){
        // require(points[msg.sender] == 0, "account not exit");
        require(points[msg.sender] >= amt, "amount not enough");
        points[msg.sender] -= amt;
        points[_to] += amt;
        return points[_to];
    }

    // 返回所有用户

    function allUserBack() public returns (address[] memory){
        return users;
    }





}

   













// contract MappingExample {
//     mapping(address => uint) public balances;

//     function update(uint newBalance) public {
//         balances[msg.sender] = newBalance;
//     }
// }

// contract MappingUser {
//     function f() public returns (uint) {
//         MappingExample m = new MappingExample();
//         m.update(100);
//         return m.balances(address(this));
//     }
// }


