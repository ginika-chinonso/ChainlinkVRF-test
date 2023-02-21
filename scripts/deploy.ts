import { ethers } from "hardhat";

async function main() {

  const [addr1] = await ethers.getSigners();

  const VRFCoordinator = "0x2Ca8E0C643bDe4C2E08ab1fA0da3401AdAD7734D"
  const SubID = 10101;

  const RANNUM = await ethers.getContractFactory("RANNUM");

  const Rannum = await RANNUM.deploy(SubID, VRFCoordinator);

  await Rannum.deployed();

  console.log(`Contract deployed at address: ${await Rannum.address}`)

  await Rannum.getReqID();

  const number = await Rannum.getRandomNum();

  console.log(`Your random number is: ${number}`);

}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
