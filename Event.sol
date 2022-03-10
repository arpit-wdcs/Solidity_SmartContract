//SPDX-License-Identifier:MIT
pragma solidity ^0.8.1;

/*********************************************
*   Contract details:                        *
*                                            *
*                                            *
*                                            *
*                                            *
*                                            *
*                                            *
*                                            *
*                                            *
*                                            *
*                                            *
*                                            *
*********************************************/

contract eventContract{

    uint biddingEnd = block.timestamp + 2 days;

    struct HighBidder{
        address bidder;
        string bidderName;
        uint biddingAmount;
    }

    HighBidder public highBidder;

    event NewHighBid(address indexed who,string name,uint howmuch);
    event BidFailed(address indexed who,string name,uint howmuch);

    modifier timeLimit{
        require(block.timestamp < biddingEnd,"Bidding time is over");
        _;
    }

    constructor() {
        //Start the Bidding at 1 ether 
        highBidder.biddingAmount= 1 ether;
    }

    function bid(string memory bidderName)public payable timeLimit{
        if(msg.value > highBidder.biddingAmount){
            highBidder.bidderName = bidderName;
            highBidder.bidder = msg.sender;
            highBidder.biddingAmount = msg.value;

            emit NewHighBid(msg.sender,bidderName,msg.value);
        }
        else{
            emit BidFailed(msg.sender,bidderName,msg.value);
            revert("You are bidding less than high Bidder Amount");
        }

    }

    function 

    





}