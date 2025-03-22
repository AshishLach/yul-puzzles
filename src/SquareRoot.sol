// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract SquareRoot {
    function main(uint256 x) external pure returns (uint256) {
        assembly {
            // your code here
            // return the square root of x rounded down
            // e.g. root(4) = 2 root(5) = 2 root(6) = 2, ..., root(8) = 2, root(9) = 3
            // hint: https://www.youtube.com/watch?v=CnMBo5nG_zk
            // hint: use x / 2 as initial guess
            // hint: be careful of overflow
            // hint: use a switch statement to handle 0, 1, and the general case
            // hint: use break to exit the loop if the new guess is the same as the old guess
            //intial guess

            switch x
            case 0 {
                mstore(0x80, 0x00)
                return(0x80, 0x20)
            }
            case 1 {
                mstore(0x80, 0x01)
                return(0x80, 0x20)
            }
            let newVal := div(x, 2)
            let oldVal := newVal
            let oldOldVal := newVal

            // Equation (g +x/g) / 2 => (g*g + x)/2g
            for {
                let i := 0
            } lt(i, x) {
                i := add(i, 1)
            } {
                oldOldVal := oldVal
                oldVal := newVal
                //OutofGas error
                // newVal := div(
                //     add(mul(newVal, newVal), x),
                //     mul(2, newVal)
                // )
                newVal := div(add(newVal, div(x, newVal)), 2)
                if eq(oldVal, newVal) {
                    mstore(0x80, newVal)
                    return(0x80, 0x20)
                }
                if eq(newVal, 0) {
                    mstore(0x80, oldVal)
                    return(0x80, 0x20)
                }
                if eq(oldVal, add(oldOldVal, 1)) {
                    mstore(0x80, newVal)
                    return(0x80, 0x20)
                }
            }

            revert(0x00, 0x00)
        }
    }
}
