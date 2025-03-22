// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract MaxOfArray {
    function main(uint256[] memory arr) external pure returns (uint256) {
        assembly {
            // your code here
            // return the maximum value in the array
            // revert if array is empty

            let len := mload(arr)
            if iszero(len) {
                revert(0, 0)
            }
            mstore(0x00, 0x00)

            for {
                let i := 0
            } lt(i, len) {
                i := add(i, 1)
            } {
                let val := mload(add(arr, mul(add(i, 1), 0x20)))
                if gt(val, mload(0x00)) {
                    mstore(0x00, val)
                }
            }

            return(0x00, 0x20)
        }
    }
}
