// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract TicketCreation {
    
    struct Ticket {
        uint256 id;
        string eventName;
        string venue;
        string date;
        string time;
        uint256 price;
        address issuer;
        bool isAvailable;
    }
    
    Ticket[] public tickets;
    
    event TicketCreated(uint256 indexed id, string eventName, string venue, string date, string time, uint256 price, address indexed issuer);
    
    function createTicket(string memory _eventName, string memory _venue, string memory _date, string memory _time, uint256 _price) public {
        uint256 id = tickets.length;
        Ticket memory newTicket = Ticket(id, _eventName, _venue, _date, _time, _price, msg.sender, true);
        tickets.push(newTicket);
        emit TicketCreated(id, _eventName, _venue, _date, _time, _price, msg.sender);
    }
    
    function getTicket(uint256 _id) public view returns (string memory, string memory, string memory, string memory, uint256, address, bool) {
        require(_id < tickets.length, "Invalid ticket id");
        Ticket memory t = tickets[_id];
        return (t.eventName, t.venue, t.date, t.time, t.price, t.issuer, t.isAvailable);
    }
    
    function getTotalTickets() public view returns (uint256) {
        return tickets.length;
    }

    function buyTicket(uint256 _id) public payable {
        require(_id < tickets.length, "Invalid ticket id");
        require(tickets[_id].isAvailable == true, "Ticket is not available");
        require(msg.value >= tickets[_id].price, "Insufficient funds");
        tickets[_id].isAvailable = false;
        payable(tickets[_id].issuer).transfer(msg.value);
        tickets[_id].issuer = msg.sender;
    }
    function getBalance() external view returns(uint) {
        return address(this).balance;
    }   
}