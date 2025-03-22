// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract WriteDynamicArrayToStorage {
    uint256[] public writeHere;

    function main(uint256[] calldata x) external {
        assembly {
            // your code here
            // write the dynamic calldata array `x` to storage variable `writeHere`

            let len := calldataload(0x24)
            mstore(0x00, 0x00)
            let ptr := keccak256(0x00, 0x20)
            for {
                let i := 0
            } lt(i, len) {
                i := add(i, 1)
            } {
                sstore(add(ptr, i), calldataload(add(0x44, mul(32, i))))
            }
            sstore(0x00, len)
        }
    }
}
