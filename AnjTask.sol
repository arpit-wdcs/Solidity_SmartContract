// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Whitelist {

    address owner;

    mapping(address => bool) whitelistedAddresses;
    mapping(address => uint)balances;

    constructor() {
      owner = msg.sender;

    }

    modifier onlyOwner() {
      require(msg.sender == owner, "Ownable: caller is not the owner");
      _;
    }

    modifier isWhitelisted(address _address) {
      require(whitelistedAddresses[_address], "Whitelist: You need to be whitelisted");
      _;
    }

    function addUser(address _addressToWhitelist) public onlyOwner {
      whitelistedAddresses[_addressToWhitelist] = true;
    }


    function BlackListed(address _addressToBlacklist) public onlyOwner {
      whitelistedAddresses[_addressToBlacklist] = true;
    }


    function verifyUser(address _whitelistedAddress) public view returns(bool) {
      bool userIsWhitelisted = whitelistedAddresses[_whitelistedAddress];
      return userIsWhitelisted;
    }

    

    function balanceOf(address account) public view returns (uint256) {
        return balances[account];
    }

}
