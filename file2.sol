// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Token.sol"; // Assurez-vous que le chemin est correct

contract TokenSale {
    Token public token;
    address public owner;
    uint256 public price; // Prix par token en wei

    event TokensPurchased(address indexed buyer, uint256 amount);

    constructor(Token _token, uint256 _price) {
        token = _token;
        owner = msg.sender;
        price = _price;
    }

    function buyTokens(uint256 _amount) public payable {
        require(msg.value == _amount * price, "Incorrect Ether value sent");
        require(token.balanceOf(address(this)) >= _amount, "Not enough tokens in the contract");

        token.transfer(msg.sender, _amount);
        emit TokensPurchased(msg.sender, _amount);
    }

    function withdraw() public {
        require(msg.sender == owner, "Only owner can withdraw");
        payable(owner).transfer(address(this).balance);
    }
}
