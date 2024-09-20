// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "./GUZtoken.sol";
import "./web3Token.sol";

contract SwapToken {

    // I feel we should create a struct of depositor 
    address public owner;
    IERC20 public tokenAddress1;
    IERC20 public tokenAddress2;
    uint public totalAmountOfTokenA;
    uint public totalAmountOfTokenB;

    mapping(address => mapping(uint => bool)) hasDepositedTokenA;
    mapping(address => mapping(uint => bool)) hasDepositedTokenB;

    constructor(address _token1, address _token2) {
        require(_token1 != _token2, "Tokens must be different");
        require(msg.sender != address(0), "Address zero is not allowed");
        tokenAddress1 = IERC20(_token1);
        tokenAddress2 = IERC20(_token2);
        owner = msg.sender;
    }

    event SuccessfulDeposit(address indexed depositor, uint amount);
    event SwapSuccessful(address indexed depositor, uint amount);

    // Function to deposit Token A (in multiples of 10)
    function addLiquidityToA(uint amount) external {
        require(msg.sender != address(0), "Zero address disallowed");
        require(amount > 0, "You cannot deposit zero amount");

        uint balanceA = tokenAddress1.balanceOf(msg.sender);
        require(balanceA >= amount, "Insufficient balance");
        require(amount % 10 == 0, "Token A must be in multiples of 10");

        bool success = tokenAddress1.transferFrom(msg.sender, address(this), amount);
        require(success, "Token A transfer failed");

        hasDepositedTokenA[msg.sender][amount] = true;
        totalAmountOfTokenA += amount;

        emit SuccessfulDeposit(msg.sender, amount);
    }

    // Function to deposit Token B (in multiples of 2)
    function addLiquidityToB(uint amount) external {
        require(msg.sender != address(0), "Zero address disallowed");
        require(amount > 0, "You cannot deposit zero amount");

        uint balanceB = tokenAddress2.balanceOf(msg.sender);
        require(balanceB >= amount, "Insufficient balance");
        require(amount % 2 == 0, "Token B must be in multiples of 2");

        bool success = tokenAddress2.transferFrom(msg.sender, address(this), amount);
        require(success, "Token B transfer failed");

        hasDepositedTokenB[msg.sender][amount] = true;
        totalAmountOfTokenB += amount;

        emit SuccessfulDeposit(msg.sender, amount);
    }

    // Swap from Token A to Token B (assuming a 1:5 ratio for simplicity)
    function swapTokenAforTokenB(uint amount) external {
        require(hasDepositedTokenA[msg.sender][amount], "You did not deposit Token A");
        require(msg.sender != address(0), "Invalid address");

        // Transfer Token A from user to contract owner
        bool successA = tokenAddress1.transfer(owner, amount);
        require(successA, "Token A transfer failed");

        // Transfer Token B from contract to user (1:5 swap ratio)
        uint amountB = amount / 5;
        bool successB = tokenAddress2.transfer(msg.sender, amountB);
        require(successB, "Token B transfer failed");

        emit SwapSuccessful(msg.sender, amount);
    }

    // Swap from Token B to Token A (assuming a 5:1 ratio for simplicity)
    function swapTokenBforTokenA(uint amount) external {
        require(hasDepositedTokenB[msg.sender][amount], "You did not deposit Token B");
        require(msg.sender != address(0), "Invalid address");

        // Transfer Token B from user to contract owner
        bool successB = tokenAddress2.transfer(owner, amount);
        require(successB, "Token B transfer failed");

        // Transfer Token A from contract to user (5:1 swap ratio)
        uint amountA = amount * 5;
        bool successA = tokenAddress1.transfer(msg.sender, amountA);
        require(successA, "Token A transfer failed");

        emit SwapSuccessful(msg.sender, amount);
    }


    function getBalanceOfTokenA(address _balance) external view returns (uint) {

        return tokenAddress1.balanceOf(_balance);
    }

    
    function getBalanceOfTokenB(address _balance) external view returns (uint) {
        return tokenAddress2.balanceOf(_balance);
    }

    function getContractBalanceOfTokenA()external view returns (uint){
        return tokenAddress1.balanceOf(address(this));
    }
    function getContractBalanceOfTokenB()external view returns (uint){
        return tokenAddress1.balanceOf(address(this));
    }
}
