// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract StructTest {


// 定义一个结构体用于存储产品信息，包括产品 ID、名称、价格和库存。实现增加、修改和查询产品信息的功能。
    struct Product{
        uint id;
        string name;
        uint price;
        uint stock;
    }

mapping (uint => Product) public products;
    // Product[] public product;
    uint id;

// 新增产品
    function addProduct(string memory pName,uint pPrice,uint pStock) public {
        id++;
        products[id] = Product(id,pName,pPrice,pStock);
    }

    // 更新产品
    function updateP(uint pId, uint newStock) public {
        Product storage p = products[pId];
        p.stock = newStock;
    }
// 获取产品
    function getProduct(uint _id) public view returns (string memory,uint,uint){
        Product storage p = products[_id];
        return (p.name,p.price,p.stock);
    }

}