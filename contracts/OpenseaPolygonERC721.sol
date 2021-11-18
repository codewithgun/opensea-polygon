pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

// SPDX-License-Identifier: MIT

contract OpenSeaPolygonERC721 is ERC721URIStorage, ERC721Enumerable, Ownable {
    //Opensea mumbai ERC721 proxy 0xff7ca10af37178bdd056628ef42fd7f799fac77c

    using Strings for uint256;

    event PermanentURI(string _value, uint256 indexed _id);

    constructor(string memory name_, string memory symbol_) ERC721(name_, symbol_) {}

    function mint(address to, uint256 tokenId) external onlyOwner {
        require(!_exists(tokenId), "id exists");
        _safeMint(to, tokenId);
        emit PermanentURI(tokenURI(tokenId), tokenId);
    }

    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 tokenId
    ) internal virtual override(ERC721, ERC721Enumerable) {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    function _burn(uint256 tokenId) internal virtual override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }
    function supportsInterface(bytes4 interfaceId) public view virtual override(ERC721, ERC721Enumerable) returns (bool) {
        return super.supportsInterface(interfaceId);
    }

    function tokenURI(uint256 tokenId) public view virtual override(ERC721, ERC721URIStorage) returns (string memory) {
        require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");

        string memory baseURI = _baseURI();
        return bytes(baseURI).length > 0 ? string(abi.encodePacked(baseURI, tokenId.toString(), ".json")) : "";
    }

    function _baseURI() internal override pure returns (string memory) {
        return "ipfs://QmbLGXvJCVK9Btymwm8htKBZgsTbEHTPZLd5BTF3PRTHRm/";
    }

    /**
    * Override isApprovedForAll to auto-approve OS's proxy contract
    * If not overriden, need to implement MetaTransaction for it
    */
    function isApprovedForAll(
        address _owner,
        address _operator
    ) public override view returns (bool isOperator) {
      // if OpenSea's ERC721 Proxy Address is detected, auto-return true
        if (_operator == address(0xff7Ca10aF37178BdD056628eF42fD7F799fAc77c)) {
            return true;
        }
        
        return ERC721.isApprovedForAll(_owner, _operator);
    }

}