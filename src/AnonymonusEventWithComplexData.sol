// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract AnonymonusEventWithComplexData {
    enum Gender {
        Male,
        Female,
        Trans
    }

    struct Person {
        string name;
        uint256 age;
        Gender gender;
    }

    // EMIT ME!!!
    event MyEvent(address indexed emitter, bytes32 indexed id, Person person);

    function main(address emitter, bytes32 id, Person memory person) external {
        assembly {
            // your code here
            // emit the `MyEvent(address,bytes32,(string,uint256,uint8))` event.
            // Anonymous events don't have the event signature (topic0) included.
            // Hint: how the `Person` struct is encoded in mem:
            //          - string offset  0x00
            //          - string length offset 0x20
            //          - age 0x40
            //          - gender 0x60
            //          - name length 0x80
            //          - name 0xA0

            mstore(0x00, 0x20)
            mstore(0x20, 0x60)
            mstore(0x40, mload(add(person, 0x20)))
            mstore(0x60, mload(add(person, 0x40)))
            mstore(0x80, mload(add(person, 0x60)))
            mstore(0xA0, mload(add(person, 0x80)))

            log3(0x00, 0xC0, 0x00, emitter, id)
        }
    }
}
