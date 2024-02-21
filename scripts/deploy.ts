import { ethers } from "hardhat";

async function main() {
  const tokenA = await ethers.deployContract("TokenA");

  await tokenA.waitForDeployment();

  console.log(`Token A Contract address: ${tokenA.target}`);

  const tokenB = await ethers.deployContract("TokenB");

  await tokenB.waitForDeployment();

  console.log(`Token A Contract address: ${tokenB.target}`);

  const tokenSwap = await ethers.deployContract("TokenSwap", [
    tokenA.target,
    tokenB.target,
  ]);

  await tokenSwap.waitForDeployment();

  console.log(`Token A Contract address: ${tokenSwap.target}`);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
