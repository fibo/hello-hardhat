// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.1;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";

import {Base64} from "./libraries/Base64.sol";

contract MyEpicNFT is ERC721URIStorage {
    // Use OpenZeppelin Counters to keep track of tokenIds
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    // I create three arrays, each with their own theme of random Colors.
    // Pick some random funny Colors, names of anime characters, foods you like, whatever!
    string[] firstColors = [
        "F4D03F",
        "76D7C4",
        "8E44AD",
        "E74C3C",
        "F0B27A",
        "AED6F1"
    ];
    string[] secondColors = [
        "F1948A",
        "82E0AA",
        "CB4335",
        "F7DC6F",
        "E59866",
        "CD6155"
    ];
    string[] thirdColors = [
        "CD6155",
        "2874A6",
        "F39C12",
        "CD6155",
        "148F77",
        "BA4A00"
    ];

    // Pass the name of the NFT and its symbol
    constructor() ERC721("Inversive Space", "INV") {
        console.log("This is my first NFT contract.");
    }

    // I create a function to randomly pick a Color from each array.
    function pickRandomFirstColor(uint256 tokenId)
        public
        view
        returns (string memory)
    {
        // I seed the random generator. More on this in the lesson.
        uint256 rand = random(
            string(abi.encodePacked("FIRST_COLOR", Strings.toString(tokenId)))
        );
        // Squash the # between 0 and the length of the array to avoid going out of bounds.
        rand = rand % firstColors.length;
        return firstColors[rand];
    }

    function pickRandomSecondColor(uint256 tokenId)
        public
        view
        returns (string memory)
    {
        uint256 rand = random(
            string(abi.encodePacked("SECOND_COLOR", Strings.toString(tokenId)))
        );
        rand = rand % secondColors.length;
        return secondColors[rand];
    }

    function pickRandomThirdColor(uint256 tokenId)
        public
        view
        returns (string memory)
    {
        uint256 rand = random(
            string(abi.encodePacked("THIRD_COLOR", Strings.toString(tokenId)))
        );
        rand = rand % thirdColors.length;
        return thirdColors[rand];
    }

    function random(string memory input) internal pure returns (uint256) {
        return uint256(keccak256(abi.encodePacked(input)));
    }

    function makeAnEpicNFT() public {
        uint256 newItemId = _tokenIds.current();

        // We go and randomly grab one Color from each of the three arrays.
        string memory firstColor = pickRandomFirstColor(newItemId);
        string memory secondColor = pickRandomSecondColor(newItemId);
        string memory thirdColor = pickRandomThirdColor(newItemId);

        string memory finalSvg = string(
            abi.encodePacked(
                '<svg version="1.1" viewBox="0.0 0.0 512 512" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.w3.org/2000/svg" <circle cx="107" cy="252" r="97" fill="#',
                firstColor,
                '"></circle> <circle cx="299" cy="371" r="129" fill="#',
                secondColor,
                '"></circle> <circle cx="279" cy="126" r="117" fill="#',
                thirdColor,
                '"></circle> <circle cx="221" cy="247.1" r="17.1" fill="#c0c0c0"></circle> <circle cx="221" cy="247.1" r="68" fill="#ffffff" fill-opacity="0.17"></circle> </svg>'
            )
        );
        console.log("\n--------------------");
        console.log(finalSvg);
        console.log("--------------------\n");

        // Get all the JSON metadata in place and base64 encode it.
    string memory json = Base64.encode(
        bytes(
            string(
                abi.encodePacked(
                    '{"name": "inversive space", "description": "where the Apollonian gasket lives", "image": "data:image/svg+xml;base64,',
                    // We add data:image/svg+xml;base64 and then append our base64 encode our svg.
                    Base64.encode(bytes(finalSvg)),
                    '"}'
                )
            )
        )
    );

    // Just like before, we prepend data:application/json;base64, to our data.
    string memory finalTokenUri = string(
        abi.encodePacked("data:application/json;base64,", json)
    );

        console.log("\n--------------------");
        console.log(finalTokenUri);
        console.log("--------------------\n");

        _safeMint(msg.sender, newItemId);

        _setTokenURI(newItemId, finalTokenUri);

        _tokenIds.increment();
        console.log(
            "An NFT w/ ID %s has been minted to %s",
            newItemId,
            msg.sender
        );
    }
}
