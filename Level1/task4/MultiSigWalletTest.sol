// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract MultiSigWalletTest {
    // 状态变量
    address[] public owners;
    mapping(address => bool) public isOwner;
    // 要求的至少授权数量
    uint256 public required;
    // 交易结构体，地址，金额，携带数据，是否执行
    struct Transaction {
        address to;
        uint256 value;
        bytes data;
        bool exected;
    }
    // 交易集合
    Transaction[] public transactions;

    // 该笔交易id=》地址=》改地址是否授权
    mapping(uint256 => mapping(address => bool)) public approved;

    // 事件

    event Deposit(address adr, uint256 amount);
    event Approve(address adr, uint256 _txId);
    event Revoke(address indexed owner, uint256 indexed txId);
    event Execute(uint256 indexed txId);
    event Submit(uint256 indexed txId);


    // receive
    receive() external payable {
        emit Deposit(msg.sender, msg.value);
    }

    // 函数修改器
    modifier onlyOwner() {
        // 判断是否是owner
        require(isOwner[msg.sender], "not owner");
        _;
    }
    modifier txExists(uint256 _txId) {
        require(_txId < transactions.length, "tx doesn`t exist");
        _;
    }
    modifier notApproved(uint256 _txId) {
        require(!approved[_txId][msg.sender], "tx already approved");
        _;
    }
    // 该笔交易没有执行
    modifier notExecuted(uint256 _txId) {
        require(!transactions[_txId].exected);
        _;
    }

    // 构造函数
    constructor(address[] memory _owners, uint256 _required) {
        // 对传入的参数做不满足条件判断
        require(_owners.length > 0, "");
        require(_required > 0 && _required < _owners.length, "");
        // 地址数组是否是正确的地址
        for (uint256 i = 0; i < _owners.length; i++) {
            address owner = _owners[i];
            // 校验地址合法性
            require(owner != address(0));
            // 判断是否已经有该地址
            require(!isOwner[_owners[i]]);
            isOwner[_owners[i]] = true;
            owners.push(_owners[i]);
        }
    }

    // 函数
    // 获取当前合约余额
    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }

    // 授权，传入交易ID，msg.sender调用该方法，
    // 则将当前合约中的该笔交易下的授权状态改为true，并提交事件。
    function approv( uint256 _txId) 
        external 
        onlyOwner 
        txExists(_txId) 
        notApproved(_txId) 
        notExecuted(_txId)
    {
        approved[_txId][msg.sender] = true;
        emit Approve(msg.sender, _txId);
    }

    // 获取所有已授权地址数量
    function getApprovalCount(uint256 _txId) public view returns(uint256 count){
        // 遍历所有需要授权的地址，计算已经授权的地址数量
        for (uint256 index = 0; index < owners.length; index ++){
            if(approved[_txId][owners[index]]){
                count += 1;
            }
        }
    }
    // 授权人数要超过最少授权人数，才会执行转账

    // 取消授权
    function revoke(uint256 _txId) 
        external 
        onlyOwner
        txExists(_txId)
        notExecuted(_txId)
    {
        // 先判断是否授权，授权才下一步
        require(approved[_txId][msg.sender],"tx not approve");
        approved[_txId][msg.sender] = false;
        emit Revoke(msg.sender,_txId);
    }

    function execute(uint256 _txId) external
        onlyOwner
        txExists(_txId)
        notExecuted(_txId)
    {
        require(getApprovalCount(_txId) >= required,"");
        // 改变执行状态。执行。提交事件。

        Transaction storage transaction = transactions[_txId];
        transaction.exected = true;
        (bool success,) = transaction.to.call{value: transaction.value}(
            transaction.data
        );
        require(success,"tx failed");
        emit Execute(_txId);
    }
    // 提交新的需要授权的交易信息
    function submit(
        address _to,
        uint256 _value,
        bytes calldata _data
    ) external onlyOwner returns(uint256){
        transactions.push(
            Transaction({to: _to, value: _value, data: _data, exected: false})
        );
        emit Submit(transactions.length - 1);
        return transactions.length - 1;
    }
}
