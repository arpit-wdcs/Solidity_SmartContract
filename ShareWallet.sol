 // SPDX-License-Identifier: MIT;

pragma solidity ^0.8.1;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

contract Allowance is Ownable{

    address public Owner;
    mapping(address => uint)balances;
    mapping(address => uint) public allowance;

    event AllowanceChanged(address indexed _forwho,address indexed _forWhom,uint _oldAmount,uint _newAmount);

    constructor(){
        Owner = msg.sender;
    }
   
    function addAllowance(address _who, uint _amount)public onlyOwner{
        emit AllowanceChanged(_who,msg.sender,allowance[_who],_amount);
        allowance[_who] = _amount;
    }

    modifier isOwner() {
    if (msg.sender != Owner) {
        revert();
    }

    _; // continue executing rest of method body
    }

    modifier ownerOrAllowed(uint _amount)  {
        require( allowance[msg.sender] > _amount, "you are not allowed");
        _;
    }

    function reduceAllowance(address _who, uint _amount)internal{
        emit AllowanceChanged(_who,msg.sender,allowance[_who],_amount);
        allowance[_who] -= _amount;
    }

}
contract ShareWallet is Allowance{

    event MoneySent(address indexed _beneficiary,uint _amount);
    event MoneyRecived(address indexed _from, uint _amount);

    function withDrawMoney(address payable _to,uint _amount)public ownerOrAllowed(_amount) isOwner {
        require(_amount <= address(this).balances,"there are not fund store in the smart contract");
        if(!isOwner()){
            reduceAllowance(msg.sender,_amount);
        }
        emit MoneySent(_to,_amount);
        _to.transfer(_amount);
    }

    fallback()external payable{
        emit MoneyRecived(msg.sender,msg.value);
    }

   
}
