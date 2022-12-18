//SPDX-License-Identifier: GPL-3.0 
pragma solidity ^0.8.0;

contract EnglishAuction{
    string public item;
    address payable public immutable seller;
    uint public endAt;
    bool public started;
    bool public ended;
    uint public highestBid;
    address public highestBidder;
    mapping(address=>uint) public bids;
    event Start(string _item,uint _currentPrice);
    event Bid(address _bidder,uint _bid);
    event End(address _highestBidder,uint _highestBid);
    constructor(string memory _item,uint _startingBid){
        item=_item;
        highestBid = _startingBid;
        seller = payable(msg.sender);
    }
    modifier onlySeller {
        require(msg.sender == seller, "WHO ARE YOU?");
        _;
    }
    modifier hasStarted {
        require(started,"IT AINT STARTED FOOL");
        _;
    }
    modifier notEnded {
        require (block.timestamp < endAt,"IT'S OVER YOU BIH");
        _;
    }
    function start() external onlySeller {
        require(!started,"ALREADY ON BIH");
        started = true;
        endAt = block.timestamp + 70;
        emit Start(item,highestBid);
    }
    function bid() public payable hasStarted  {
        require(msg.value > highestBid,"YOU BROKE? NOT ENOUGH");
        if(highestBidder != address(0)){
            bids[highestBidder] +=highestBid;
        }
        highestBid = msg.value;
        highestBidder = msg.sender;
        emit Bid(msg.sender, msg.value);
    }
    function end() external hasStarted {
        require(!ended,"already ended");
        require(block.timestamp >= endAt,"CAN'T STOP MANNY");
        ended = true;
        if (highestBidder != address(0)){
            seller.transfer(highestBid);
        }
        emit End(highestBidder,highestBid);
    }
    function withdraw() external {
        uint refund = bids[msg.sender];
        require(refund > 0,"incorrect");

        bids[msg.sender] = 0;
        payable(msg.sender).transfer(refund);
    }
}