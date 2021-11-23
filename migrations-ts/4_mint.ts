const OpenSeaPolygonERC721 = artifacts.require("OpenSeaPolygonERC721");

module.exports = async function (deployer, network, accounts) {
	const contract = await OpenSeaPolygonERC721.deployed();
	console.log("Contract", contract.address);
	const mintTransaction = await contract.mint(accounts[0], 0);
    console.log("View at", `https://mumbai.polygonscan.com/tx/${mintTransaction.tx}`)
} as Truffle.Migration;
