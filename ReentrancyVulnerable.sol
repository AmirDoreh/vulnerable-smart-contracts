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
 * The Reentrancy attack stands as one of the most detrimental 
 * threats to Solidity smart contracts. It unfolds when a function
 * initiates an external call to an untrusted contract, which 
 * subsequently loops back to the original function in a recursive 
 * manner, aiming to deplete funds. 
 *
 * 
 */

 contract ReentrancyVul {
    mapping(address => uint) public balances;

    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw() public {
        uint bal = balances[msg.sender];
        require(bal > 0);

        (bool sent, ) = msg.sender.call{value: bal}("");
        require(sent, "Failed to send Ether");

        balances[msg.sender] = 0;
    }


}