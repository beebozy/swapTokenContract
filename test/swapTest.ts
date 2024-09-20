import { ethers } from "hardhat";
import { expect } from "chai";
import { loadFixture } from "@nomicfoundation/hardhat-toolbox/network-helpers";

const guzAddress= "0x8fa26e0ce9da0f05aC7356E0492AE7167D241a30";
const web3Address="0x95e99D01DF7aDF3c7071b72ba536BDEaFe0108D9";
describe("SwapToken contract", function () {
  async function deployContracts() {
    const [owner, otherAccount,guzAddress,web3Address] = await ethers.getSigners();

    const Guz = await ethers.getContractFactory("Guz");
    const deployedGuz = await Guz.deploy();

    const Web3CXI = await ethers.getContractFactory("web3CXI");
    const deployedWeb3 = await Web3CXI.deploy();

    const SwapToken = await ethers.getContractFactory("SwapToken");
    const deployedSwapToken = await SwapToken.deploy(guzAddress, web3Address);

    return { owner, otherAccount, deployedGuz, deployedWeb3, deployedSwapToken };
  }

  describe("Deployment", function () {
    it("Should set the correct owner", async function () {
      const { deployedSwapToken, owner } = await loadFixture(deployContracts);
      expect(await deployedSwapToken.owner()).to.equal(owner.address);
    });
    it("should check the deployed address", async function (){
        const {deployedSwapToken,deployedGuz,deployedWeb3}= await loadFixture(deployContracts);

        expect(await deployedSwapToken.tokenAddress2()).to.equal("0x90F79bf6EB2c4f870365E785982E1f101E93b906")
        
    });
    describe("AddLiquidity to A",function(){
        it("should check for zero address", async function () {
            const {deployedSwapToken,owner,otherAccount}= await loadFixture(deployContracts);
            expect( await deployedSwapToken.connect(otherAccount)).to.be.revertedWith("Zero address disallowed");
        });
        it("should transfer the amount",async function(){
            const {deployedSwapToken,owner,deployedWeb3,otherAccount}= await loadFixture(deployContracts);
            const amount= ethers.parseUnits("1",18);
           //deployedWeb3.transfer(otherAccount,amount);
           
           const transferAmount = ethers.parseUnits("10", 18);
           await deployedWeb3.transfer(otherAccount.address, transferAmount);
     
           // Check balances
           const otherAccountBalance = await deployedWeb3.balanceOf(otherAccount.address);
           expect(otherAccountBalance).to.equal(transferAmount);
         });


         
         describe("Add liquidity to B",function (){
          it("should check for zero address", async function () {
            const {deployedSwapToken,owner,otherAccount}= await loadFixture(deployContracts);
            expect( await deployedSwapToken.connect(otherAccount)).to.be.revertedWith("Zero address disallowed");
        });
        it("should transfer the amount",async function(){
            const {deployedSwapToken,owner,deployedWeb3,otherAccount}= await loadFixture(deployContracts);
            const amount= ethers.parseUnits("1",18);
           //deployedWeb3.transfer(otherAccount,amount);
           
           const transferAmount = ethers.parseUnits("10", 18);
           await deployedWeb3.transfer(otherAccount.address, transferAmount);
     
           // Check balances
           const otherAccountBalance = await deployedWeb3.balanceOf(otherAccount.address);
           expect(otherAccountBalance).to.equal(transferAmount);
         });

          describe("It should check the balance", function(){
           
          })
         } )
    })
  });
});
