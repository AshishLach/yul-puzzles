// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract CalculatorInFallback {
    uint256 public result;

    fallback() external {
        assembly {
            // your code here
            // compare the function selector in the calldata with the any of the selectors below, then
            // execute a logic based on the right function selector and store the result in `result` variable.
            // assumming operations won't overflow

            // add(uint256,uint256) -> 0x771602f7 (add two numbers and store result in storage)
            // sub(uint256,uint256) -> 0xb67d77c5 (sub two numbers and store result in storage)
            // mul(uint256,uint256) -> 0xc8a4ac9c (mul two numbers and store result in storage)
            // div(uint256,uint256) -> 0xa391c15b (div two numbers and store result in storage)
            calldatacopy(0x00, 0x00, 0x04)
            let fun := mload(0x00)
            calldatacopy(0x20, 0x04, 0x20)
            let x := mload(0x20)
            calldatacopy(0x40, 0x24, 0x20)
            let y := mload(0x40)

            switch fun
            case 0x771602f700000000000000000000000000000000000000000000000000000000 {
                sstore(0, add(x, y))
            }
            case 0xb67d77c500000000000000000000000000000000000000000000000000000000 {
                sstore(0, sub(x, y))
            }
            case 0xc8a4ac9c00000000000000000000000000000000000000000000000000000000 {
                sstore(0, mul(x, y))
            }
            case 0xa391c15b00000000000000000000000000000000000000000000000000000000 {
                sstore(0, div(x, y))
            }
        }
    }
}
