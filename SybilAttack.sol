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
 * The Sybil attack aims to sway systems disproportionately,
 * a risk seen in blockchain networks and smart contracts. 
 * Attackers create fake accounts or nodes, manipulate voting 
 * mechanisms, and spam transactions. Mitigation strategies 
 * include proof of stake protocols, captcha applications, 
 * and setting minimum balance requirements. Captchas also 
 * deter reputation-based manipulations through bot accounts.
 * 
 */

contract SybilAttackVulnerable {
    mapping(address => uint256) public votes;
    address[] public candidates;

    function vote(address candidate) public {
        votes[candidate] += 1;
    }

    function addCandidate(address candidate) public {
        candidates.push(candidate);
    }

    function getWinner() public view returns (address) {
        require(candidates.length > 0, "No candidates added");
        
        address winner = candidates[0];
        uint256 maxVotes = votes[winner];

        for (uint256 i = 1; i < candidates.length; i++) {
            address candidate = candidates[i];
            if (votes[candidate] > maxVotes) {
                winner = candidate;
                maxVotes = votes[candidate];
            }
        }
        return winner;
    }
}
