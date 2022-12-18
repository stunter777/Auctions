//SPDX-License-Identifier: GPL-3.0 
pragma solidity ^0.8.0;

contract DutchAuction {
    uint private constant DURATION = 2 days;
    uint public immutable startPrice;
    uint public immutable startsAt;
    uint public immutable endsAt;
    uint public immutable discountRate;
    address payable public immutable seller;
    string public item;
    bool public stopped;
    constructor(
        uint _startPrice,
        uint _discountRate,
        string memory _item
    ){
        startPrice = _startPrice;
        discountRate = _discountRate;
        startsAt = block.timestamp;
        endsAt = block.timestamp + DURATION;
        item = _item;
        seller = payable(msg.sender);
        require(_startPrice>_discountRate*DURATION,"fuck you doin?");

        item=_item;
    }
    modifier notStopped(){
        require(!stopped,"off wit you bih");
        _;
    }
    function getPrice() public view notStopped returns(uint){
        uint timeElapsed = block.timestamp - startsAt;
        uint discount = discountRate*timeElapsed;
        return startPrice - discount;
    }
    function buy() external payable notStopped {
        require(block.timestamp<endsAt,"OVER WIT U BIH");
        uint price = getPrice();
        require(msg.value >= price,"WHO YOU FOOLIN?");
        uint refund = msg.value - price;
        if (refund>0){
            payable(msg.sender).transfer(refund);
        }
        seller.transfer(address(this).balance);
        stopped = true;
    }
}