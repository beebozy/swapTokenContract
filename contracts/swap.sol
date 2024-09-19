
// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.24;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "./GUZtoken.sol";
import "./web3Token.sol";

contract swapToken{

    address public owner;
    IERC20 public tokenAddress1;
    IERC20 public tokenAddress2;
   uint public totalAmountoftokenA;
   uint public totalAmountoftokenB;
    mapping(address=>mapping(uint=>bool))hasdepositedtokenA;
    mapping(address=>mapping(uint=>bool))hasdepositedtokenB;
    constructor(address _token1, address _token2){
        require(_token1!=_token2,"Token has to be different");
        require(msg.sender!=address(0), "Adress zero not allowed");
        tokenAddress1= IERC20(_token1);
        tokenAddress2= IERC20(_token2);
        owner= msg.sender;
    }
    event successfulDeposit(address indexed depositor, uint amount);

function addliquidityTOA()external{
    require(msg.sender!=address(0),"Zero address disallowed");
    require(msg.value>0,"You cannot deposit zero amount");
    // we need to implement in such a way that the token a deposit multiples of 10 and tooken be multiples of 2
    uint balanceA= tokenAddress1.balanceOf(msg.sender);
    uint balanceB= tokenAddress2.balanceOf(msg.sender);

    require(balanceA >0,"Balance has to be greater than zero");
    require(balanceA%10==0,"Guz token must in 10 multiples");
   
    bool success = tokenAddress1.transferFrom(msg.sender, address(this), amount);
        require(success, "Token transfer failed");

        // Update state
        hasDepositedTokenA[msg.sender] = true;
        totalAmountOfTokenA += amount;

        // Emit event after successful deposit
        emit SuccessfulDeposit(msg.sender, msg.value);

}

function addliquidityTOB()external{
    require(msg.sender!=address(0),"Zero address disallowed");
    require(msg.value>0,"You cannot deposit zero amount");
    // we need to implement in such a way that the token a deposit multiples of 10 and tooken be multiples of 2

    uint balanceB= tokenAddress2.balanceOf(msg.sender);

    require(balanceB >0,"Balance has to be greater than zero");
    require(balanceB%2==0,"Guz token must in 10 multiples");
   
    bool success = tokenAddress2.transferFrom(msg.sender, address(this), amount);
        require(success, "Token transfer failed");

        // Update state
        hasDepositedTokenB[msg.sender] = true;
        totalAmountOfTokenB += amount;

        // Emit event after successful deposit
        emit SuccessfulDeposit(msg.sender, msg.value);

}


}