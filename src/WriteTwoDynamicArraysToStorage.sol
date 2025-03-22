// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract WriteTwoDynamicArraysToStorage {
    uint256[] public writeHere1;
    uint256[] public writeHere2;

    function main(uint256[] calldata x, uint256[] calldata y) external {
        assembly {
            // your code here
            // write the dynamic calldata array `x` to storage variable `writeHere1` and
            // dynamic calldata array `y` to storage variable `writeHere2`

            // 4 + 20 + 20 +actualdata arg len(20) + first val

            calldatacopy(0x00, 0x44, 0x20)
            let len1 := mload(0x00)

            let arr2Start := add(0x64, mul(32, len1))
            calldatacopy(0x20, arr2Start, 0x20)
            let len2 := mload(0x20)

            sstore(0, len1)
            sstore(1, len2)
            mstore(0x40, 0x00)
            mstore(0x60, 0x01)
            let ptr1 := keccak256(0x40, 0x20)
            let ptr2 := keccak256(0x60, 0x20)

            for {
                let i := 0
            } lt(i, len1) {
                i := add(i, 1)
            } {
                let val := mul(32, add(i, 1))
                let copyPtr := add(0x60, val)
                calldatacopy(copyPtr, add(0x44, val), 0x20)
                sstore(add(ptr1, i), mload(copyPtr))
            }

            let currentPtr := add(0x60, mul(32, len1))

            for {
                let i := 0
            } lt(i, len2) {
                i := add(i, 1)
            } {
                let val := mul(32, add(i, 1))
                let copyPtr := add(currentPtr, val)
                calldatacopy(copyPtr, add(arr2Start, val), 0x20)
                sstore(add(ptr2, i), mload(copyPtr))
            }
        }
    }
}
