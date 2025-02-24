// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.26;

contract WETH {


    mapping (address => uint) public balanceOf;

    mapping (address => mapping (address => uint256)) public allowance;
    event Deposit(address _adr,uint256 amount);
    event Withdraw(address _adr,uint256 amount);
    event Approval(address indexed src,address indexed  delegateAds, uint256 amount);
    event Transfer(address src,address toads,uint256 amount);
    constructor() {
        
    }

    // 查看当前合约的总量
    function totalSupply() external view  returns (uint256) {
        return address(this).balance;
    }



    function deposit() public payable {
        balanceOf[msg.sender] += msg.value;
        emit Deposit(msg.sender,msg.value);
    }


    function withdraw(uint256 amount) public {
        // 判断当前合约中，这个地址是否有足够余额
        require(balanceOf[msg.sender] >= amount);
        balanceOf[msg.sender] -= amount;
        // 有足够余额，赚钱给msg.sender。并减少msg.sender在这个合约中的存款
        payable(msg.sender).transfer(amount);
        emit Withdraw(msg.sender,amount);
    }

    // msg.sender授权delegateAds  amount数量的钱
    // 此处的授权并不是使用方法授权的（例如erc20中的授权某个地址可以使用多少代币）
    function approve(address delegateAds,uint256 amount) public returns (bool){
        allowance[msg.sender][delegateAds] = amount;
        emit Approval(msg.sender,delegateAds,amount);
        return true;
    }

    function transferFrom (
        address src,
        address toAds,
        uint256 amount
    ) public returns (bool){
        require(balanceOf[src] >= amount);
        // 如果是授权地址(msg.sender),谁的钱(src)
        if(src != msg.sender){
            require(allowance[src][msg.sender] >= amount);
            // 把授权的数量减少
            allowance[src][msg.sender] -= amount;
        }
        balanceOf[src] -= amount;
        balanceOf[toAds] += amount;
        emit Transfer(src,toAds,amount);
        return true;
    }


    // fallback可以处理接受ETH，也可以处理调用合约中不存在的函数
    fallback() external payable{
        deposit();
    }
    // 可以处理接受ETH，写法是固定的
    receive() external payable{
        deposit();
    }


}