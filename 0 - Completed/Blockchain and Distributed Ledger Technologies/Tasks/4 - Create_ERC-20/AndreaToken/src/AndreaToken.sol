// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";

contract AndreaToken is ERC20 {

    function decimals() public view virtual override returns (uint8) {
        return 18;
    }

    constructor(uint256 initialSupply) ERC20("AndreaToken", "1808606") {
        _mint(msg.sender, initialSupply);
    }
}