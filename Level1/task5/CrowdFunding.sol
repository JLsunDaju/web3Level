// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.17;

contract CrowdFunding {
    // 受益人地址
    address public immutable beneficiary;
    // 目标捐款数
    uint256 public immutable fundingGoal;
    // 当前金额
    uint256 public fundingAmount;
    // 捐款人=》金额
    mapping (address => uint256) public funders;
    // 捐款人地址
    address[] public fundersKey;
    // 可迭代的映射
    mapping(address=>bool) private fundersInserted;
    // 不用自销毁方法，使用变量来控制
    bool public AVAILABLED = true; // 状态

    constructor(address _adr, uint256 goal_) {
        beneficiary = _adr;
        fundingGoal = goal_;
    }

    function contribute() external payable {
        // 是否关闭捐款箱
        require(AVAILABLED,"CorwdFunding is closed");
        // 分情况 如果当前捐款不会超过总金额，如果会超过
        uint256 potentialFundingAmount  = fundingAmount + msg.value;
        // 退还金额
        uint256 refundAmount = 0;
        if(potentialFundingAmount > fundingGoal){
            refundAmount = potentialFundingAmount - fundingGoal;
            fundingAmount += (msg.value - refundAmount);
        } else {
            funders[msg.sender] += msg.value;
            fundingAmount += msg.value;
        }
        if(!fundersInserted[msg.sender]){
            fundersInserted[msg.sender] = true;
            fundersKey.push(msg.sender);
        }
        // 处理退还金额
        if(refundAmount > 0){
            payable(msg.sender).transfer(refundAmount);
        }
    }

    // 是否关闭
    function colse() external returns(bool){
        // 如果不到总金额，不给提现，直接返回
        if(fundingAmount < fundingGoal){
            return false;
        }
        uint256 amount = fundingAmount;
        fundingAmount = 0;
        // 关闭状态不接受捐款
        AVAILABLED = false;
        payable(beneficiary).transfer(amount);
        return true;

    }
}