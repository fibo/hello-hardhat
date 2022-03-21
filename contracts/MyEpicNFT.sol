// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.1;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";

contract MyEpicNFT is ERC721URIStorage {
  // Use OpenZeppelin Counters to keep track of tokenIds
  using Counters for Counters.Counter;
  Counters.Counter private _tokenIds;

  // Pass the name of the NFT and its symbol
  constructor() ERC721 ("SquareNFT", "SQUARE") {
    console.log("This is my first NFT contract.");
  }

  function makeAnEpicNFT() public {
    // Get the current tokenId, starts at 0.
    uint256 newItemId = _tokenIds.current();

    // Mint the NFT to the sender.
    _safeMint(msg.sender, newItemId);

    // Set the NFTs data.
    _setTokenURI(newItemId, "https://g14n.info/hello-hardhat/metadata-100.json");

    console.log("An NFT w/ ID %s has been minted to %s", newItemId, msg.sender);

    // Increment counter.
    _tokenIds.increment();
  }
}
