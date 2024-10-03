import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";



const  webModule = buildModule("webModule", (m) => {
 

  const lock = m.contract("web3CXI")

  return { lock };
});

export default  webModule;
