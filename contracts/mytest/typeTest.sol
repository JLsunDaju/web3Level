
// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

/*
请编写一个 Solidity 智能合约，实现以下功能：

数组的操作：合约中包含一个 storage 存储的动态数组 data。
编写一个函数 updateData(uint[] memory newData)，该函数接收一个 memory 数组并将其内容复制到 data 中。
然后通过另一个函数 getData() 返回 data 数组。

引用类型的行为：在合约中编写两个函数：

modifyStorageData(uint index, uint value)：修改 data 数组中指定索引位置的值。
modifyMemoryData(uint[] memory memData)：尝试修改传入的 memory 数组，并返回修改后的数组。
请解释每个函数的 Gas 消耗及其背后的原因。
*/
contract TypeTest {

    uint[] data;

    function updateData(uint[] memory newData) public {
        data = newData;
    }

    // 返回storage中的data数组
    function getData() public view returns (uint[] memory) {
        return data; // 返回storage中的数据作为memory中的数组
    }

    function modifyStorageData(uint index,uint value) public {
        require(index < data.length, "Index out of bounds");
        data[index] = value;
    }

    function modifyMemoryData(uint[] memory memData) public returns (uint[] memory){
        if (memData.length > 0) {
            memData[0] = 999; // 修改memory中的值，开销较小
        }
        return memData;
    }

}