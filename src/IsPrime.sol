// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract IsPrime {
    event LogEvent(bool val);

    function main(uint256 x) external returns (bool) {
        bytes32 topic = keccak256("LogEvent(bool)");

        assembly {
            // your code here
            // return true if x is a prime number, else false
            // 1. check if the number is a multiple of 2 or 3
            // 2. loop from 5 to x / 2 to see if it is divisible
            // 3. increment the loop by 2 to skip the even numbers
            let temp := true

            if eq(x, 1) {
                temp := false
            }
            if iszero(mod(x, 2)) {
                temp := false
            }
            if iszero(mod(x, 3)) {
                temp := false
            }
            for {
                let i := 5
            } lt(i, mod(x, 2)) {
                i := add(i, 1)
            } {
                if iszero(mod(x, i)) {
                    temp := false
                }
            }
            let data := mload(0x40) // Get free memory pointer
            mstore(data, temp) // Store bool (true = 1, false = 0)
            log1(data, 32, topic) // Emit log1 with 1 topic
            if iszero(temp) {
                mstore(
                    0x00,
                    0x0000000000000000000000000000000000000000000000000000000000000000
                )
            }
            if iszero(iszero(temp)) {
                mstore(
                    0x00,
                    0x0000000000000000000000000000000000000000000000000000000000000001
                )
            }
            return(0x00, 0x20)
        }
    }
}
