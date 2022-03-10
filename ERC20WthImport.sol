// SPDX-License-Identifier: MIT
pragma solidity ^0.8.1;

interface IERC20{

    function totalSupply()external view returns(uint);

   // function balanceOf(address account)external view returns(uint);

    function transfer(address  recipient,uint amount)external returns(bool);

   // function transferFrom(address sender,address recipient,uint amount)external view returns(bool);

   // function allowance(address owner,address spender)external view returns(uint);

   // function approve(address spender, uint amount)external view returns(bool);

    event Transfer(address indexed from,address indexed to, uint value);
    //event approval(address indexed owner, address indexed spender,uint value);
}
library SafeMath {
 
    function safeAdd(uint a, uint b) public pure returns (uint c) {
        c = a + b;
        require(c >= a);
    }
 
    function safeSub(uint a, uint b) public pure returns (uint c) {
        require(b <= a);
        c = a - b;
    }
 
    function safeMul(uint a, uint b) public pure returns (uint c) {
        c = a * b;
        require(a == 0 || c / a == b);
    }
 
    function safeDiv(uint a, uint b) public pure returns (uint c) {
        require(b > 0);
        c = a / b;
    }
}


contract Arpit is IERC20{
    using SafeMath for uint256;
    address public owner;
    uint public totalSupply;
    mapping(address => uint)balances;
    mapping(address => mapping(address => uint))allowance;
    string public name = "ArpitToken";
    string public symbol = "Arp";
    uint public decimal = 18;

    constructor(uint _totalSupply){
        totalSupply = _totalSupply;
        balances[msg.sender]=totalSupply;
        
        //owner = msg.sender;
    }
    /*modifier onlyOwner(){
        require(msg.sender==owner);
        _;
    }*/

    function balanceOf(address account)external view returns(uint){
        return balances[account];
    }

    function transfer(address  recipient, uint amount)public  returns(bool){
        balances[msg.sender] = balances[msg.sender].safeSub(amount);//(balances[msg.sender.], amount);
        balances[recipient] = balances[recipient].safeAdd(amount);
        emit Transfer(msg.sender,recipient,amount);
        return true;

    }


    


}

