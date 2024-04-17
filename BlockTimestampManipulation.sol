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
 * This contract is designed to demonstrate Block Timestamp Manipulation,
 * where miners have the ability to manipulate the block.timestamp, 
 * subject to specific constraints. These constraints include the inability 
 * to set a timestamp earlier than its parent block and ensuring that the timestamp 
 * is not too far in the future.
 * 
 */
contract BlockTimestampVulnerable {
    uint256 public pastBlockTime;

    constructor() payable {}

    function spin() external payable {
        require(msg.value == 1 ether); // 1 eth must be send while calling this function
        require(block.timestamp != pastBlockTime); // only 1 transaction per block is alowed

        pastBlockTime = block.timestamp;

        if (block.timestamp % 12 == 0) {
            (bool sent,) = msg.sender.call{value: address(this).balance}("");
            require(sent, "Failed to send Ether");
        }
    }
}
