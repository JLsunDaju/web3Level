// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.26;

contract Demo {

    struct Todo {
        string name;
        bool iscomplate;
    }

    Todo[] public todoList;
 
//  创建任务
    function creat(string memory _name) public{
        todoList.push(Todo({
            name: _name,
            iscomplate: false
        }));
    }
    
    // 直接修改任务名字
    function editName1(uint256 index,string memory newName) external {
        todoList[index].name = newName;
    }
    // 修改任务名字
    function editName2(uint256 index,string memory newName) external {
        Todo storage temp = todoList[index];
        temp.name = newName;
    }

    // 修改任务状态
    function editStatus(uint256 index,bool  _iscomplate) external {
        todoList[index].iscomplate = _iscomplate;

    }
    // 修改任务状态
    function editStatus2(uint256 index) external {
        todoList[index].iscomplate = !todoList[index].iscomplate;

    }

    function get1(uint256 index) external view returns(string memory name,bool iscomplate){
        Todo memory temp = todoList[index];
        return (temp.name,temp.iscomplate);
        // name = todoList[index].name;
        // iscomplate = todoList[index].iscomplate;         
    }

    function get2(uint256 index) external view returns(string memory name,bool iscomplate){
        Todo storage temp = todoList[index];
        return (temp.name,temp.iscomplate);
        // name = todoList[index].name;
        // iscomplate = todoList[index].iscomplate;         
    }
}