import * as dotenv from "dotenv";
import path from "path";
dotenv.config({
	path: path.join(__dirname, "..", ".env")
});

const name: string = process.env.COLLECTION_NAME || "";
const symbol: string = process.env.COLLECTION_SYMBOL || "";

const OpenSeaPolygonERC721 = artifacts.require("OpenSeaPolygonERC721");

module.exports = function (deployer) {
	deployer.deploy(OpenSeaPolygonERC721, name, symbol);
} as Truffle.Migration;
