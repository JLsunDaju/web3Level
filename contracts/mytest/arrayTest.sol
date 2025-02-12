// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract ArrayRemoveByShifting {
    // [1, 2, 3] -- remove(1) --> [1, 3, 3] --> [1, 3]
    // [1, 2, 3, 4, 5, 6] -- remove(2) --> [1, 2, 4, 5, 6, 6] --> [1, 2, 4, 5, 6]
    // [1, 2, 3, 4, 5, 6] -- remove(0) --> [2, 3, 4, 5, 6, 6] --> [2, 3, 4, 5, 6]
    // [1] -- remove(0) --> [1] --> []

    // 声明一个动态大小的无符号 256 位整数数组
    uint256[] public arr;

    // 定义一个公共函数，用于移除数组中指定索引位置的元素
    function remove(uint256 _index) public {
        // 检查传入的索引是否越界，如果越界则抛出异常
        require(_index < arr.length, "index out of bound");

        // 从指定索引位置开始，将后续元素依次向前移动一位
        for (uint256 i = _index; i < arr.length - 1; i++) {
            arr[i] = arr[i + 1];
        }
        // 移除数组的最后一个元素，因为前面元素移动后，最后一个元素是重复的
        arr.pop();
    }

    function test() external {
        arr = [1, 2, 3, 4, 5];
        // 调用 remove 函数移除索引为 2 的元素
        remove(2);
        // [1, 2, 4, 5]
        // 使用断言检查数组中各元素的值是否符合预期
        assert(arr[0] == 1);
        assert(arr[1] == 2);
        assert(arr[2] == 4);
        assert(arr[3] == 5);
        // 检查数组的长度是否为 4
        assert(arr.length == 4);

        // 重新初始化数组为 [1]
        arr = [1];
        // 调用 remove 函数移除索引为 0 的元素
        remove(0);
        // []
        // 移除后数组应为空
        // 检查数组的长度是否为 0
        assert(arr.length == 0);
    }
}

contract ArrayReplaceFromEnd {
    // 声明一个动态的无符号 256 位整数数组，用于存储数据
    uint256[] public arr;

    // Deleting an element creates a gap in the array.
    // One trick to keep the array compact is to
    // move the last element into the place to delete.
    // 此函数用于从数组中移除指定索引位置的元素
    // 常规删除元素会在数组中留下空缺，为保持数组紧凑，采用将最后一个元素移到待删除位置的方法
    function remove(uint256 index) public {
        // Move the last element into the place to delete
        // 将数组的最后一个元素赋值给待删除索引位置的元素
        // 以此覆盖掉原位置的元素
        arr[index] = arr[arr.length - 1];
        // Remove the last element
        // 移除数组的最后一个元素，因为它已经被移到前面去了
        arr.pop();
    }

    function test() public {
        arr = [1, 2, 3, 4];

        remove(1);
        // [1, 4, 3]
        assert(arr.length == 3);
        assert(arr[0] == 1);
        assert(arr[1] == 4);
        assert(arr[2] == 3);

        remove(2);
        // [1, 4]
        assert(arr.length == 1);
        assert(arr[0] == 1);
        assert(arr[1] == 4);
    }
}


// pragma solidity 0.8.26;

// /*
// 编写合约，允许用户动态管理一个地址数组。
// 实现一个函数，接收数组作为参数并返回其元素之和。
// 创建一个函数，删除数组中的特定元素并调整数组长度。
// */
// contract ArrayTest {
//     uint [] public addressArr =  [1,2,3,4,5];

//     function reduce(uint[] memory data1) public pure  returns (uint){
//         uint sum = 0;
//         for (uint i = 0; i < data1.length; i++) 
//         {
//             sum += data1[i]; 
//         }
//         return sum;
//     }

//     function deleteArryReturnArr(uint256 index) public   returns (uint[] memory){
//         require(index < addressArr.length,"index out of bound");
//         for (uint i = index; i < addressArr.length; i++) 
//         {
//             addressArr[i] = addressArr[i++];
//         }
//         addressArr.pop();
//         return addressArr;
 
//     }

//     // 实现一个合约，使用 bytes 和 string 数组处理用户输入，并提供字符或字节数组的相关操作。

    
// }