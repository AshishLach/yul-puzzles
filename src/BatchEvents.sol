// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract BatchEvents {
    // EMIT ME!!!
    event MyEvent(address indexed emitter, bytes32 indexed id, uint256 num);

    function main(
        address[] memory emitters,
        bytes32[] memory ids,
        uint256[] memory nums
    ) external {
        bytes32 signature = keccak256("MyEvent(address,bytes32,uint256)");

        assembly {
            // your code here
            // emit the `MyEvent(address,bytes32,uint256)` event
            // Assuming all arrays (emitters, ids, and nums) are of equal length.
            // iterate over the set of parameters and emit events based on the array length.

            let len := mload(emitters)
            for {
                let i := 0
            } lt(i, len) {
                i := add(i, 1)
            } {
                mstore(0x00, mload(add(nums, mul(32, add(i, 1)))))
                log3(
                    0x00,
                    0x20,
                    signature,
                    mload(add(emitters, mul(32, add(i, 1)))),
                    mload(add(ids, mul(32, add(i, 1))))
                )
            }
        }
    }
}
