// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";


contract web3CXI is ERC20{
    constructor() ERC20("Web3token", "W3T") {
        require(msg.sender != address(0), "Address zero not allowed");

        // Mint initial supply of 1000 tokens to the owner (deployer)
        _mint(msg.sender, 1000 * (10 ** decimals()));
    }

    // Only the owner can mint more tokens
    function mint(address account, uint256 amount) external  {
        _mint(account, amount);
    }
}


// 0x95e99D01DF7aDF3c7071b72ba536BDEaFe0108D9 web3token

//  - https://sepolia-blockscout.lisk.com//address/0x95e99D01DF7aDF3c7071b72ba536BDEaFe0108D9#code
