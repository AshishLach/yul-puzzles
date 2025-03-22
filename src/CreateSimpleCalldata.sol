// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract CreateSimpleCalldata {
    function main(
        bytes calldata deploymentBytecode
    ) external returns (address) {
        assembly {
            // your code here
            // create a contract using the deploymentBytecode
            // return the address of the contract
            // hint: use the `create` opcode
            // hint: use calldatacopy to copy the deploymentBytecode to memory
            calldatacopy(0x00, 0x24, 0x20)
            let len := mload(0x00)
            calldatacopy(0x20, 0x44, len)

            let addr := create(0, 0x20, len)
            if iszero(addr) {
                revert(0, 0)
            }
            mstore(0x80, addr)
            return(0x80, 0x20)
        }
    }
}
