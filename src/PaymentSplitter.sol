// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract PaymentSplitter {
    function main(address[] calldata recipients) external payable {
        assembly {
            // your code here
            // send the entire contract balance to the recipients
            // each recipient gets balance / recipients.length
            let len := recipients.length
            let valPerRecipient := div(selfbalance(), len)
            for {
                let i := 0
            } lt(i, len) {
                i := add(i, 1)
            } {
                calldatacopy(0x00, add(0x24, mul(add(i, 1), 32)), 0x20)

                let to := mload(0x00)
                if iszero(
                    call(gas(), to, valPerRecipient, 0x00, 0x00, 0x00, 0x00)
                ) {
                    revert(0, 0)
                }
            }
        }
    }
}
