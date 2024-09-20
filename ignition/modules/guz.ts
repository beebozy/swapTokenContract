import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";



const GuzModule = buildModule("GuzModule", (m) => {
 

  const lock = m.contract("Guz")

  return { lock };
});

export default GuzModule;

/*

webModule#web3CXI - 0x95e99D01DF7aDF3c7071b72ba536BDEaFe0108D9
GuzModule#Guz - 0x8fa26e0ce9da0f05aC7356E0492AE7167D241a30

Verifying deployed contracts

Verifying contract "contracts/web3Token.sol:web3CXI" for network lisk-sepolia...
Contract contracts/web3Token.sol:web3CXI already verified on network lisk-sepolia:
  - https://sepolia-blockscout.lisk.com//address/0x95e99D01DF7aDF3c7071b72ba536BDEaFe0108D9#code

Verifying contract "contracts/GUZtoken.sol:Guz" for network lisk-sepolia...
Successfully verified contract "contracts/GUZtoken.sol:Guz" for network lisk-sepolia:
  - https://sepolia-blockscout.lisk.com//address/0x8fa26e0ce9da0f05aC7356E0492AE7167D241a30#code
*/