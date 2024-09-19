// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract Guz is ERC20{
    constructor() ERC20("GUZToken", "GUZ") {
        require(msg.sender != address(0), "Address zero not allowed");

        // Mint initial supply of 1000 tokens to the owner (deployer)
        _mint(msg.sender, 1000 * (10 ** decimals()));
    }

    // Only the owner can mint more tokens
    function mint(address account, uint256 amount) external  {
        _mint(account, amount);
    }
}
