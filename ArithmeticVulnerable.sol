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
 * Arithmetic problems like integer overflow and underflow are frequent 
 * vulnerabilities in Solidity smart contracts. They arise when unsigned 
 * integers surpass their maximum value or drop below their minimum, leading 
 * to unexpected outcomes. This article will delve into the attack vectors 
 * associated with arithmetic issues in Solidity. 
 * 
 */

contract ArithmeticVulnarable {
    uint256[] public arrayOfThings;
    mapping(address => uint256) public balances;
    constructor() {
        // Initialize the array with some values for demonstration
        arrayOfThings.push(1);
        arrayOfThings.push(2);
        arrayOfThings.push(3);
    }
    function withdraw(uint _amount) public  {
    require(balances[msg.sender] - _amount > 0);
    payable(msg.sender).transfer(_amount);
    balances[msg.sender] -= _amount;
    }

    function popArrayOfThings() public {
    require(arrayOfThings.length >= 0);
    arrayOfThings.pop();
    }

    function votes(uint postId, uint upvote, uint downvotes) public  {
    if (upvote - downvotes < 0) {
        deletePost(postId);
    }
    }
    function deletePost(uint _postId) private {
        // Implementation to delete the post
    }
}
