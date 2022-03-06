// SPDX-License-Identifier: MIT
pragma solidity >=0.4.0 <0.9.0;

import "contracts/myERC20.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";
contract staking is AccessControl{
    myERC20 public rewardsToken;
    myERC20 public stakingToken;

    bytes32 public constant ADMIN_ROLE = keccak256("ADMIN_ROLE");

    uint public rewardRate = 10;
    uint public lastUpdateTime;
    uint public rewardPerTokenStored;
    uint256 lastRun;

    mapping(address => uint) public userRewardPerTokenPaid;
    mapping(address => uint) public rewards;

    event Transfer(address _from, address _to, uint256 _value);
    event Approval(address _owner, address _spender, uint256 _value);

    uint public totalSupply;
    mapping(address => uint) private balances;

    constructor(address _stakingToken, address _rewardsToken) {
        stakingToken = myERC20(_stakingToken);
        rewardsToken = myERC20(_rewardsToken);
        _setupRole(ADMIN_ROLE, _stakingToken);
    }
    
    function setRewardRate(uint reward) external{
        require(hasRole(ADMIN_ROLE, msg.sender), "Caller is not a admin");
        rewardRate = reward; 
    }

    function setLastUpdateTime(uint lastTime) external{
        require(hasRole(ADMIN_ROLE, msg.sender), "Caller is not a admin");
        lastUpdateTime = lastTime;
    }

    function rewardPerToken() private view returns (uint) {
        if (totalSupply == 0) {
            return 0;
        }
        return rewardPerTokenStored + (((block.timestamp - lastUpdateTime) * rewardRate * 1e18) / totalSupply);
    }

    function earned(address account) private view returns (uint) {
        return ((balances[account] * (rewardPerToken() - userRewardPerTokenPaid[account])) / 1e18) + rewards[account];
    }

    modifier updateReward(address account) {
        rewardPerTokenStored = rewardPerToken();
        lastUpdateTime = block.timestamp;

        rewards[account] = earned(account);
        userRewardPerTokenPaid[account] = rewardPerTokenStored;
        _;
    }

    function stake(uint amount) external updateReward (msg.sender){
        //require(block.timestamp - lastUpdateTime > 10 minutes, 'Need to wait 10 minutes'); 
        require(amount > 0, 'Amount do not be null'); 
        totalSupply += amount;
        balances[msg.sender] += amount;
        emit Transfer(msg.sender, address(this), amount); 
    }

    function unstake() external updateReward(msg.sender) {
        //require(block.timestamp - lastUpdateTime > 20 minutes, 'Need to wait 20 minutes');
        require(totalSupply > 0, 'Amount do not be null');
        emit Transfer(msg.sender, address(this), balances[msg.sender]); 
        balances[msg.sender] -= totalSupply;
        totalSupply = 0;
    }

    function claim() external updateReward(msg.sender) {
        require(rewards[msg.sender] > 0, 'Amount do not be null');
        uint reward = rewards[msg.sender];
        rewards[msg.sender] = 0;
        emit Transfer(msg.sender, address(this), reward); 
    }
}
