// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract KeccakFirstCalldata {
    function main(uint256 x, uint256, uint256) external returns (bytes32) {
        bytes32 e = keccak256(abi.encode(x));
        assembly {
            // your code here
            // return the keccak hash of the FRIST argument in the calldata
            // Hint: use keccak256(offset, size)
            // Hint: don't forget to account for the offset
            // read this article for hints: https://www.rareskills.io/post/abi-encoding
            //        assertEq(r, keccak256(abi.encode(x)));

            calldatacopy(0x00, 0x04, 0x20)
            mstore(0x00, keccak256(0x00, 0x20))
            return(0x00, 0x20)
        }
    }
}
