// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
/*
 * This contract is being deployed by the authors of the "Systematic Review of Blockchain Security Vulnerabilities" paper.
 * 
 * Authors:
 * - Amirmohammad Doreh
 * - Buğra Varlı 
 * - Zakariya Younis 
 * - Ilyas Chamsou 
 * 
 * 
 * 
 * External data reliance can expose smart contracts to vulnerabilities,
 * potentially enabling attackers to manipulate resources and steal funds.
 *
 * 
 */

contract ConvergenceAttack {

  address payable public owner;
  uint public price;

  constructor(address payable _owner, uint _price) {
    owner = _owner;
    price = _price;
  }

  function buy() public payable {
    require(msg.value >= price);
    owner.transfer(msg.value);
  }

  function updatePrice(uint _newPrice) public {
    require(msg.sender == owner);
    price = _newPrice;
  }
}
