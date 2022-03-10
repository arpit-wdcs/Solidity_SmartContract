//SPDX-License-Identifier: MIT
pragma solidity ^0.8.1;
import '@openzeppelin/contracts/token/ERC20/IERC20.sol';

contract EthStore{
    address public owner;
    uint public regFee;

    IERC20 public Token = IERC20(0xcD6a42782d230D7c13A74ddec5dD140e55499Df9);

    mapping (address => uint) public balance; 

    constructor()  {
    owner = msg.sender;
    regFee = 1 ether;
    }
    
    event reg(address indexed _from);

    function deposite() payable external {
    require(msg.value >= regFee);
    balance[address(this)] += regFee;     
    emit reg(msg.sender); 
    }
    

    function balanceOf(address tokenOwner) public view returns (uint256) {
        return balance[tokenOwner];
    }

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }  
}