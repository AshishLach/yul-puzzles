// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract SendEther {
    function main(address payable to, uint256 amount) external payable {
        assembly {
            // your code here
            // send `amount` of ether to `to`
            // assume `amount` is less than or equal to the contract balance
            // assume `amount` is in wei
            // hint: use the `call` opcode: https://docs.soliditylang.org/en/latest/yul.html#evm-dialect
            // hint: use the `gas` opcode to get the gas left

            //call contract at address a with input mem[in…(in+insize)) providing g gas and v wei and output area mem[out…(out+outsize)) returning 0 on error (eg. out of gas) and 1 on success See more

            if iszero(call(gas(), to, amount, 0x00, 0x00, 0x00, 0x00)) {
                revert(0, 0)
            }
        }
    }
}
