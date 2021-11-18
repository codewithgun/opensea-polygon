import * as dotenv from "dotenv";
import path from "path";
dotenv.config({
	path: path.join(__dirname, "..", ".env")
});

const name: string = process.env.COLLECTION_NAME || "";
const symbol: string = process.env.COLLECTION_SYMBOL || "";

const ERC2309 = artifacts.require("ERC2309");

module.exports = function (deployer) {
	deployer.deploy(ERC2309, name, symbol, "ipfs://QmbLGXvJCVK9Btymwm8htKBZgsTbEHTPZLd5BTF3PRTHRm/");
} as Truffle.Migration;
