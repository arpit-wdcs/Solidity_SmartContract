pragma solidity ^0.4.25;

contract ModifiersContract {
    // State variable
    address owner;
    uint value;

    constructor()public{
        owner =msg.sender;
        }

     modifier ownerOnly(){
        require(msg.sender==owner);
        _;
    }


    function anyoneCanCall () public returns (bool) {
        value = 100;
        return true;
    }

    function onlyOwnerCanCall () ownerOnly public returns (bool success) {
        value = 100;
        return true;
    }
}