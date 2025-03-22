// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract EventWithComplexData {
    // EMIT ME!!!
    event MyEvent(address indexed emitter, address[] players, uint256[] scores);

    function main(
        address emitter,
        address[] memory players,
        uint256[] memory scores
    ) external {
        bytes32 signature = keccak256("MyEvent(address,address[],uint256[])");
        assembly {
            // your code here
            // emit the `MyEvent(address,address[],uint256[])` event
            // Hint: Use `log2` to emit the event with the hash as the topic0 and `emitter` as topic1, then the data
            let len1 := mload(players)
            let len2 := mload(scores)

            let arr2Ptr := add(0x60, mul(32, len1))
            mstore(0x00, 0x40)
            mstore(0x20, arr2Ptr)
            mstore(0x40, len1)

            for {
                let i := 0
            } lt(i, len1) {
                i := add(i, 1)
            } {
                mstore(
                    add(0x40, mul(32, add(i, 1))),
                    mload(add(players, mul(32, add(i, 1))))
                )
            }
            mstore(arr2Ptr, len2)

            for {
                let i := 0
            } lt(i, len2) {
                i := add(i, 1)
            } {
                mstore(
                    add(arr2Ptr, mul(32, add(i, 1))),
                    mload(add(scores, mul(32, add(i, 1))))
                )
            }
            let size := add(add(0x60, mul(32, len1)), add(0x20, mul(32, len2)))

            log2(0x00, size, signature, emitter)
        }
    }
}
