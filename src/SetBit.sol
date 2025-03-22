// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract SetBit {
    function main(uint256 x, uint8 i) external pure returns (uint256) {
        assembly {
            // your code here
            // set the i-th bit of x to 1, keeping every other bit the same
            // return the result
            // 10011 (actual value- suppose 2th bit to be replaced with 1 starting with 05h)
            // 00001 (value of 1)
            // 00100 (result of shl(2, 1))
            // 10011  or operation with actual value)
            // 10111  final result (2th bit replaced with 1!)
            mstore(0x00, or(shl(i, 1), x))
            return(0x00, 0x20)
        }
    }
}
