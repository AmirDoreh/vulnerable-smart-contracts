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
 * Smart contracts sometimes need extra signatures for transactions.
 * Attackers exploit code weaknesses to fake these signatures and 
 * approve unauthorized transactions. To prevent this, review and 
 * validate the code thoroughly, fix any issues, and consider
 * using a trusted multi-signature wallet., 
 * 
 * 
 */

contract MultiSigVulnerableWallet {
    address[] public owners;
    uint public threshold;
    mapping(address => bool) public isOwner;
    mapping(uint => mapping(address => bool)) public isApproved;
    uint public transactionCount;

    constructor(address[] memory _owners, uint _threshold) {
        require(_owners.length > 0, "Owners required");
        require(_threshold > 0 && _threshold <= _owners.length, "Invalid threshold");
        owners = _owners;
        threshold = _threshold;
        for (uint i = 0; i < _owners.length; i++) {
            isOwner[_owners[i]] = true;
        }
    }

    modifier onlyOwner() {
        require(isOwner[msg.sender], "Not an owner");
        _;
    }

    function submitTransaction(address to) public onlyOwner {
        require(to != address(0), "Invalid recipient");
        uint transactionId = transactionCount++;
        for (uint i = 0; i < owners.length; i++) {
            isApproved[transactionId][owners[i]] = false;
        }
        isApproved[transactionId][msg.sender] = true;
        approveTransaction(transactionId);
    }

    function approveTransaction(uint transactionId) public onlyOwner {
        require(isApproved[transactionId][msg.sender] == false, "Already approved");
        isApproved[transactionId][msg.sender] = true;
        uint approvals;
        for (uint i = 0; i < owners.length; i++) {
            if (isApproved[transactionId][owners[i]]) {
                approvals++;
            }
        }
        if (approvals >= threshold) {
            executeTransaction(transactionId);
        }
    }

    function executeTransaction(uint transactionId) private {
        require(transactionId < transactionCount, "Invalid transaction ID");
        require(isApproved[transactionId][msg.sender], "Transaction not approved");

        address to = 0x8BbF363f475212775b5B06966906A14F0e82121B ;
        uint amount = 100;

        // Perform the fund transfer
        payable(to).transfer(amount);
    }
}
