// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract ReturnTupleOfString {
    function main() external pure returns (string memory, string memory) {
        assembly {
            // your code here
            // return the tuple of string: ("Hello", "RareSkills")

            mstore(0x00, 0x40) //offset
            mstore(0x20, 0x80) //offset
            mstore(0x40, 0x05) //len1
            mstore(0x60, "Hello") //string
            mstore(0x80, 0x0A) //len2
            mstore(0xA0, "RareSkills") //string
            return(0x00, 0xC0)
        }
    }
}
