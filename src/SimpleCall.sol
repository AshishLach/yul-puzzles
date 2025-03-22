// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract SimpleCall {
    function main(address t) external payable {
        assembly {
            // your code here
            // call "t.foo()"
            // hint: "foo()" has function selector 0xc2985578

            mstore(
                0x00,
                0xc298557800000000000000000000000000000000000000000000000000000000
            )
            if iszero(call(gas(), t, 0, 0x00, 0x04, 0x00, 0x00)) {
                // 0x20 - 0x04
                revert(0x00, 0x00)
            }
        }
    }
}
