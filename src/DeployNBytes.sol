// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

/*
  Initialization Code:
  
  60 size
  PUSH1 0x01
  Push the length (size byte) of the runtime code onto the stack.
  
  60 0c
  PUSH1 0x0c
  Push the offset where the runtime code begins. Here the init code is 12 bytes long (0x0c in hex).
  
  60 00
  PUSH1 0x00
  Push the memory destination offset (0) where the runtime code will be copied.
  
  39
  CODECOPY
  Copy size byte (the length from earlier) from the code starting at offset 0x0c (i.e. right after this init code) into memory at offset 0.
  
  60 size
  PUSH1 0x01
  Push the length (size byte) again for the return.
  
  60 00
  PUSH1 0x00
  Push the memory start (0) for returning.
  
  f3
  RETURN
  Return the 1 byte from memory as the contract’s runtime code.
  
  Runtime Code (appended byte):
  
  00
  This is the one byte that will be installed as the deployed contract’s code. In EVM, 0x00 is the STOP opcode.
*/

contract DeployNBytes {
    function main(uint256 size) external returns (address) {
        assembly {
            // your code here
            // create a contract that is size bytes long
            // hint: you will need to generalize the init code of DeployOneByte
            // hint: use mstore8 to target a single byte
            // hint: because we only care about the size, you can simply return that region
            //       of memory and not care about what is inside it
            mstore(0x00, size)
            mstore(
                0x80,
                0x6001600c60003960016000f30000000000000000000000000000000000000000
            )

            mstore8(add(0x80, 8), size)
            let addr := create(0, 0x80, 0x0D)
            if iszero(addr) {
                revert(0, 0)
            }
            mstore(0xA0, addr)
            return(0xA0, 0x20)
        }
    }
}
