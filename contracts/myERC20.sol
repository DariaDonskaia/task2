// SPDX-License-Identifier: Unlicense
pragma solidity >=0.4.0 <0.9.0;

import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract myERC20{
    using SafeMath for uint256;

    mapping (address => uint256)  balances;
    mapping (address => mapping (address => uint256))  allowed;
 
    string tokenName;                   
    uint8 tokenDecimals;                
    string tokenSymbol;                 
    uint256 tokenTotalSupply;

    event Transfer(address _from, address _to, uint256 _value);
    event Approval(address _owner, address _spender, uint256 _value);

    constructor(string memory name,  string memory symbol){                   
        tokenName = name;                                   
        tokenDecimals = 16;                            
        tokenSymbol = symbol;                               
    }

    function allowance(address owner, address spender) external view returns (uint256){
        return allowed[owner][spender];
    }

    function balanceOf(address account) external view returns (uint256){
        return balances[account];
    }

    function totalSupply() external view returns (uint256){
        return tokenTotalSupply;
    }

    function name() public view returns (string memory){
        return tokenName;
    }

    function decimals() public view returns (uint8){
        return tokenDecimals;
    }

    function symbol() public view returns (string memory){
        return tokenSymbol;
    }

    function transfer(address recipient, uint256 amount) external returns (bool){
        require(recipient != address(0), "Recipient cannot be the zero address.");
        require(balances[msg.sender] >= amount, "The caller must have a balance of at least amount.");
        balances[msg.sender] -= amount;
        balances[recipient] += amount;
        emit Transfer(msg.sender, recipient, amount); 
        return true;
    }

    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool){
        require(recipient != address(0), "Recipient cannot be the zero address.");
        require(sender != address(0), "Sender cannot be the zero address.");
        require(balances[sender] >= amount, "Sender must have a balance of at least amount.");
        require(allowed[sender][recipient] >= amount, "The caller must have allowance for sender's tokens of at least amount.");
        balances[recipient] += amount;
        balances[sender] -= amount;
        emit Transfer(sender, recipient, amount); 
        return true;
    }

    function approve(address spender, uint256 amount) external returns (bool){
        require(spender != address(0), "Spender cannot be the zero address.");
        allowed[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount); 
        return true;   
    }

    function increaseAllowance(address spender, uint256 addedValue) public returns (bool){
        require(spender != address(0), "Spender cannot be the zero address.");
        allowed[msg.sender][spender] = allowed[msg.sender][spender].add(addedValue);
        emit Approval(msg.sender, spender, allowed[msg.sender][spender]);
        return true;
    }

    function decreaseAllowance(address spender, uint256 subtractedValue) public returns (bool){
        require(spender != address(0), "Spender cannot be the zero address.");
        require(allowed[msg.sender][spender] >= subtractedValue, "Spender must have allowance for the caller of at least subtractedValue.");
        allowed[msg.sender][spender] = (allowed[msg.sender][spender].sub(subtractedValue));
        emit Approval(msg.sender, spender, allowed[msg.sender][spender]);
        return true;   
    }

    //Add a role Minter in the future 
    function mint(address account, uint256 amount) public returns (bool){
        require(account != address(0), "Account cannot be the zero address.");
        balances[msg.sender] += amount;
        tokenTotalSupply += amount;
        emit Transfer(msg.sender, account, amount); 
        return true;
    }

    function burn(uint256 amount) public returns (bool){
        require(balances[msg.sender] >= amount, "Sender must have a balance of at least amount.");
        balances[msg.sender] -= amount;
        tokenTotalSupply -= amount;
        emit Transfer(msg.sender, address(0), amount);
        return true;
    }
}