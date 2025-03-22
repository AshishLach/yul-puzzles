// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract Division {
    function main(int256 x, int256 y) external returns (int256) {
        assembly {
            // your code here
            // x and y can be negative or positive
            // return x / y
            // if y == 0 revert
            // if iszero(y) {
            //     revert(0x00, 0x00)
            // }
            // mstore(0x80, sdiv(x, y))
            // return(0x80, 0x20)
            if iszero(y) {
                revert(0x00, 0x00)
            }
            let x_postive := true
            let y_postive := true
            if slt(x, 0) {
                x := add(not(x), 1)
                x_postive := false
            }
            if slt(y, 0) {
                y := add(not(y), 1)
                y_postive := false
            }
            let result := div(x, y)
            log1(0, 0, x_postive)
            log1(0, 0, y_postive)
            if eq(x_postive, y_postive) {
                log1(0, 0, 0x033)
                mstore(0x80, result)
                return(0x80, 0x20)
            }
            //result to be converted into negative as both are neither postives nor negatives
            result := add(not(result), 1)
            mstore(0x80, result)
            return(0x80, 0x20)
        }
    }
}
