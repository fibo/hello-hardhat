// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.1;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";

contract MyEpicNFTv1 is ERC721URIStorage {
    // Use OpenZeppelin Counters to keep track of tokenIds
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    // Pass the name of the NFT and its symbol
    constructor() ERC721("Inversive Space", "INV") {
        console.log("This is my first NFT contract.");
    }

    function makeAnEpicNFT() public {
        // Get the current tokenId, starts at 0.
        uint256 newItemId = _tokenIds.current();

        // Mint the NFT to the sender.
        _safeMint(msg.sender, newItemId);

        // Set the NFTs data.
        _setTokenURI(
            newItemId,
            "data:application/json;base64,ewogICJuYW1lIjogImludmVyc2l2ZSBzcGFjZSIsCiAgImRlc2NyaXB0aW9uIjogIndoZXJlIHRoZSBBcG9sbG9uaWFuIGdhc2tldCBsaXZlcyIsCiAgImltYWdlIjogImRhdGE6aW1hZ2Uvc3ZnK3htbDtiYXNlNjQsUEhOMlp3b2dJSFpsY25OcGIyNDlJakV1TVNJS0lDQjJhV1YzUW05NFBTSXdMakFnTUM0d0lEVXhNaUExTVRJaUNpQWdabWxzYkQwaWJtOXVaU0lLSUNCemRISnZhMlU5SW01dmJtVWlDaUFnZUcxc2JuTTZlR3hwYm1zOUltaDBkSEE2THk5M2QzY3Vkek11YjNKbkx6RTVPVGt2ZUd4cGJtc2lDaUFnZUcxc2JuTTlJbWgwZEhBNkx5OTNkM2N1ZHpNdWIzSm5Mekl3TURBdmMzWm5JZ28rQ2lBZ1BHTnBjbU5zWlNCamVEMGlNVEEzSWlCamVUMGlNalV5SWlCeVBTSTVOeUlnWm1sc2JEMGlJek16TXpNek15SStDaUFnSUNBOFlXNXBiV0YwWlNCaGRIUnlhV0oxZEdWT1lXMWxQU0p5SWlCaVpXZHBiajBpTUhNaUlHWnliMjA5SWpBaUlIUnZQU0k1TnlJZ2NtVndaV0YwUTI5MWJuUTlJakVpSUdSMWNqMGlNWE1pSUM4K0NpQWdQQzlqYVhKamJHVStDaUFnUEdOcGNtTnNaU0JqZUQwaU1qazVJaUJqZVQwaU16Y3hJaUJ5UFNJeE1qa2lJR1pwYkd3OUlpTXpNek16TXpNaVBnb2dJQ0FnUEdGdWFXMWhkR1VnWVhSMGNtbGlkWFJsVG1GdFpUMGljaUlnWW1WbmFXNDlJakJ6SWlCbWNtOXRQU0l3SWlCMGJ6MGlNVEk1SWlCeVpYQmxZWFJEYjNWdWREMGlNU0lnWkhWeVBTSXhjeUlnTHo0S0lDQThMMk5wY21Oc1pUNEtJQ0E4WTJseVkyeGxJR040UFNJeU56a2lJR041UFNJeE1qWWlJSEk5SWpFeE55SWdabWxzYkQwaUl6TXpNek16TXlJK0NpQWdJQ0E4WVc1cGJXRjBaU0JoZEhSeWFXSjFkR1ZPWVcxbFBTSnlJaUJpWldkcGJqMGlNSE1pSUdaeWIyMDlJakFpSUhSdlBTSXhNVGNpSUhKbGNHVmhkRU52ZFc1MFBTSXhJaUJrZFhJOUlqRnpJaUF2UGdvZ0lEd3ZZMmx5WTJ4bFBnb2dJRHhqYVhKamJHVWdZM2c5SWpFd055SWdZM2s5SWpJMU1pSWdjajBpTUNJZ1ptbHNiRDBpSXpNek16TXpNeUlnWm1sc2JDMXZjR0ZqYVhSNVBTSXdMaklpUGdvZ0lDQWdQR0Z1YVcxaGRHVWdZWFIwY21saWRYUmxUbUZ0WlQwaWNpSWdZbVZuYVc0OUlqRnpJaUJtY205dFBTSTVOeUlnZEc4OUlqRXhOQ0lnY21Wd1pXRjBRMjkxYm5ROUlqRWlJR1IxY2owaU1TNDNjeUlnWm1sc2JEMGlabkpsWlhwbElpOCtDaUFnSUNBOFlXNXBiV0YwWlNCaGRIUnlhV0oxZEdWT1lXMWxQU0ptYVd4c0xXOXdZV05wZEhraUlHSmxaMmx1UFNJeUxqZHpJaUJtY205dFBTSXdMaklpSUhSdlBTSXdJaUJ5WlhCbFlYUkRiM1Z1ZEQwaU1TSWdaSFZ5UFNJeGN5SWdabWxzYkQwaVpuSmxaWHBsSWk4K0NpQWdQQzlqYVhKamJHVStDaUFnUEdOcGNtTnNaU0JqZUQwaU1qazVJaUJqZVQwaU16Y3hJaUJ5UFNJd0lpQm1hV3hzUFNJak16TXpNek16SWlCbWFXeHNMVzl3WVdOcGRIazlJakF1TWlJK0NpQWdJQ0E4WVc1cGJXRjBaU0JoZEhSeWFXSjFkR1ZPWVcxbFBTSnlJaUJpWldkcGJqMGlNWE1pSUdaeWIyMDlJakV5T1NJZ2RHODlJakUwTmlJZ2NtVndaV0YwUTI5MWJuUTlJakVpSUdSMWNqMGlNUzQzY3lJZ1ptbHNiRDBpWm5KbFpYcGxJaTgrQ2lBZ0lDQThZVzVwYldGMFpTQmhkSFJ5YVdKMWRHVk9ZVzFsUFNKbWFXeHNMVzl3WVdOcGRIa2lJR0psWjJsdVBTSXlMamR6SWlCbWNtOXRQU0l3TGpJaUlIUnZQU0l3SWlCeVpYQmxZWFJEYjNWdWREMGlNU0lnWkhWeVBTSXhjeUlnWm1sc2JEMGlabkpsWlhwbElpOCtDaUFnUEM5amFYSmpiR1UrQ2lBZ1BHTnBjbU5zWlNCamVEMGlNamM1SWlCamVUMGlNVEkySWlCeVBTSXdJaUJtYVd4c1BTSWpNek16TXpNeklpQm1hV3hzTFc5d1lXTnBkSGs5SWpBdU1pSStDaUFnSUNBOFlXNXBiV0YwWlNCaGRIUnlhV0oxZEdWT1lXMWxQU0p5SWlCaVpXZHBiajBpTVhNaUlHWnliMjA5SWpFeE55SWdkRzg5SWpFek5DSWdjbVZ3WldGMFEyOTFiblE5SWpFaUlHUjFjajBpTVM0M2N5SWdabWxzYkQwaVpuSmxaWHBsSWk4K0NpQWdJQ0E4WVc1cGJXRjBaU0JoZEhSeWFXSjFkR1ZPWVcxbFBTSm1hV3hzTFc5d1lXTnBkSGtpSUdKbFoybHVQU0l5TGpkeklpQm1jbTl0UFNJd0xqSWlJSFJ2UFNJd0lpQnlaWEJsWVhSRGIzVnVkRDBpTVNJZ1pIVnlQU0l4Y3lJZ1ptbHNiRDBpWm5KbFpYcGxJaTgrQ2lBZ1BDOWphWEpqYkdVK0NpQWdQR05wY21Oc1pTQmplRDBpTWpJeElpQmplVDBpTWpRM0xqRWlJSEk5SWpBaUlHWnBiR3c5SWlOak1HTXdZekFpUGdvZ0lDQWdQR0Z1YVcxaGRHVWdZWFIwY21saWRYUmxUbUZ0WlQwaWNpSWdZbVZuYVc0OUlqSXVOM01pSUdaeWIyMDlJakFpSUhSdlBTSXhOeTR4SWlCeVpYQmxZWFJEYjNWdWREMGlNU0lnWkhWeVBTSXhMamN4Y3lJZ1ptbHNiRDBpWm5KbFpYcGxJaUF2UGdvZ0lEd3ZZMmx5WTJ4bFBnb2dJRHhqYVhKamJHVWdZM2c5SWpJeU1TSWdZM2s5SWpJME55NHhJaUJ5UFNJd0lpQm1hV3hzUFNJalptWm1abVptSWlCbWFXeHNMVzl3WVdOcGRIazlJakF1TVRjaVBnb2dJQ0FnUEdGdWFXMWhkR1VnWVhSMGNtbGlkWFJsVG1GdFpUMGljaUlnWW1WbmFXNDlJakl1TjNNaUlHWnliMjA5SWpBaUlIUnZQU0kyT0NJZ2NtVndaV0YwUTI5MWJuUTlJakVpSUdSMWNqMGlOQzQwY3lJZ1ptbHNiRDBpWm5KbFpYcGxJaUF2UGdvZ0lDQWdQR0Z1YVcxaGRHVWdZWFIwY21saWRYUmxUbUZ0WlQwaVptbHNiQzF2Y0dGamFYUjVJaUJpWldkcGJqMGlNaTQzY3lJZ1puSnZiVDBpTVNJZ2RHODlJakF1TVRjaUlISmxjR1ZoZEVOdmRXNTBQU0l4SWlCa2RYSTlJakp6SWlCbWFXeHNQU0ptY21WbGVtVWlJQzgrQ2lBZ1BDOWphWEpqYkdVK0Nqd3ZjM1puUGdvPSIKfQo="
        );

        console.log(
            "An NFT w/ ID %s has been minted to %s",
            newItemId,
            msg.sender
        );

        // Increment counter.
        _tokenIds.increment();
    }
}