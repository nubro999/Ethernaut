const { ethers } = require("ethers");
require("dotenv").config();

async function main() {
const rpcUrl = process.env.RPC_URL;
const pk = process.env.PRIVATE_KEY;
if (!rpcUrl || !pk) throw new Error("RPC_URL / PRIVATE_KEY 설정 필요");

const provider = new ethers.JsonRpcProvider(rpcUrl);
const wallet = new ethers.Wallet(pk, provider);

// initcode = [생성 코드] + [런타임 코드(10바이트)]
const initcode = "0x600a600c600039600a6000f3602a60005260206000f3";

console.log("Deploying from:", await wallet.getAddress());
const tx = await wallet.sendTransaction({ data: initcode });
console.log("tx hash:", tx.hash);

const rc = await tx.wait();
// EOA에서 create로 배포한 경우, contractAddress가 채워짐
const contractAddress = rc.contractAddress;
console.log("Deployed solver at:", contractAddress);

// 코드 크기 확인
const code = await provider.getCode(contractAddress);
console.log("Runtime code bytes:", (code.length - 2) / 2, "bytes");
console.log("Runtime code:", code);
}

main().catch((e) => {
console.error(e);
process.exit(1);
});