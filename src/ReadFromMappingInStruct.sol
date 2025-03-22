// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract ReadFromMappingInStruct {
    struct RandomValues {
        uint256 someValue1; //slot 1
        uint128 someValue2; //slot 2
        uint128 someValue3; //slot 2
        mapping(uint256 index => uint256) readMe; //slot 3 (base slot of mapping)
        uint256 someValue4; //slot 4
    }

    uint256 someValue5 = 7; //slot 0
    RandomValues randValues;

    function setValue(
        uint256 i,
        uint256 v,
        uint256 s1,
        uint128 s2,
        uint128 s3,
        uint256 s4,
        uint256 s5
    ) external {
        randValues.someValue1 = s1;
        randValues.someValue2 = s2;
        randValues.someValue3 = s3;
        randValues.someValue4 = s4;
        randValues.readMe[i] = v;
        someValue5 = s5;
    }

    function main(uint256 index) external returns (uint256) {
        assembly {
            // your code here
            // within the struct `RandomValues`, read from the mapping `readMe` at `index`
            // and return it
            // Hint: https://www.rareskills.io/post/solidity-dynamic

            mstore(0x00, index)
            mstore(0x20, 3)
            let ptr := keccak256(0x00, 0x40)
            mstore(0x40, sload(ptr))
            return(0x40, 0x20)
        }
    }
}
