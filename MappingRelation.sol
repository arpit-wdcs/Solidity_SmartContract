//SPDX-License-Identifier: MIT
pragma solidity ^0.8.1;

contract Mappingcontract{

    mapping(string => string) relations;

    function addRelation(string memory name,string memory relation) public{
        relations[name]=relation;
    }

    function getRelation(string memory name)public view returns(string memory){
        return relations[name];

    }
}