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
 * Approach for identifying replay attacks involves examining 
 * potential transactions to be added to the blockchain. It 
 * validates timestamps within a specified window and verifies 
 * the absence of transaction IDs in the repository. If a potential 
 * transaction's timestamp falls within the validation window and its 
 * ID is not in the repository, it's deemed unrelated to a replay attack. 
 *
 * 
 */
import "./ECDSA.sol";

contract ReplayAttackMultisigWallet {
    using ECDSA for bytes32;

    address[2] public owners;

    constructor(address[2] memory _owners) payable {
        owners = _owners;
    }

    function deposit() external payable {}

    function transfer(address _to, uint256 _amount, bytes[2] memory _sigs)
        external
    {
        bytes32 txHash = getTxHash(_to, _amount);
        require(_checkSigs(_sigs, txHash), "invalid sig");

        (bool sent,) = _to.call{value: _amount}("");
        require(sent, "Failed to send Ether");
    }

    function getTxHash(address _to, uint256 _amount)
        public
        view
        returns (bytes32)
    {
        return keccak256(abi.encodePacked(_to, _amount));
    }

    function _checkSigs(bytes[2] memory _sigs, bytes32 _txHash)
        private
        view
        returns (bool)
    {
        bytes32 ethSignedHash = _txHash.toEthSignedMessageHash();

        for (uint256 i = 0; i < _sigs.length; i++) {
            address signer = ethSignedHash.recover(_sigs[i]);
            bool valid = signer == owners[i];

            if (!valid) {
                return false;
            }
        }

        return true;
    }
}