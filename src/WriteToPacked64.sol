// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract WriteToPacked64 {
    uint64 public someValue1 = 7;
    uint64 public writeHere = 1;
    uint64 public someValue2 = 7;
    uint64 public someValue3 = 7;

    function main(uint256 v) external {
        assembly {
            // your code here
            // change the value of `writeHere` storage variable to `v`
            // be careful not to alter the value of `someValue` variable
            // mstore(0x00, sload(0))
            // mstore(0x80, v)
            // mstore(0x10, v)
            // mstore(0x10, mload(0x20))
            // sstore(0, mload(0x00))
            //someValue3 + someValue2 + writeHere + someValue1
            let slot := sload(0)
            log1(0,0,slot)
            let cleared := and(slot, 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000FFFFFFFFFFFFFFFF)
            let shiftedRight := shr(64,cleared)
            let updated := or(shiftedRight,v)
            let shiftedLeft := shl(64,updated)
            let last64Bits := and(slot, 0x00000000000000000000000000000000FFFFFFFFFFFFFFFF)
            let final := or(shiftedLeft,last64Bits)
            sstore(0,final)
            log1(0,0,final)



         }
    }
}
