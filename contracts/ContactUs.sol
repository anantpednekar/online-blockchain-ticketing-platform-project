// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract ContactUs {
    struct Message {
        address sender;
        uint256 timestamp;
        string content;
    }

    Message[] public messages;

    function sendMessage(string memory content) public {
        messages.push(Message(msg.sender, block.timestamp, content));
    }

    function getMessageCount() public view returns (uint256) {
        return messages.length;
    }

    function getMessage(uint256 index) public view returns (address, uint256, string memory) {
        require(index < messages.length, "Invalid message index");
        return (messages[index].sender, messages[index].timestamp, messages[index].content);
    }
}
