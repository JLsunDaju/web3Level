// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

// 编写一个合约 Car，包括属性 speed 和函数 drive。编写一个继承 Car 的合约 ElectricCar，在其中重写 drive 函数并增加属性 batteryLevel。
abstract contract Car {
    uint public speed;
    function drive() virtual public;
}

contract ElCar is Car{

    uint batteryLevel;
    function drive()  public override {
        batteryLevel = 2;
    }
}