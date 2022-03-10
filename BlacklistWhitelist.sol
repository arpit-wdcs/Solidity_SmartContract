// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Whitelist {

    address owner;

    mapping(address => bool) whitelistedAddresses;
    mapping(address=>bool) isBlacklisted;
    mapping(address => uint)balances;

    constructor() {
      owner = msg.sender;

    }

    modifier onlyOwner() {
      require(msg.sender == owner, "Ownable: caller is not the owner");
      _;
    }

   
    function addUser(address _addressToWhitelist) public onlyOwner {
      whitelistedAddresses[_addressToWhitelist] = true;
    }


    function blackList(address _user) public onlyOwner {
        require(!isBlacklisted[_user], "user already blacklisted");
        isBlacklisted[_user] = true;
        // emit events as well
    }


    function verifyUser(address _whitelistedAddress) public view returns(bool) {
      bool userIsWhitelisted = whitelistedAddresses[_whitelistedAddress];
      return userIsWhitelisted;
    }  

    function balanceOf(address account) public view returns (uint256) {
        require(whitelistedAddresses[account] == true);
        return balances[account];
    }

}
