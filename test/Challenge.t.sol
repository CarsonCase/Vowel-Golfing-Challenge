// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {DistanceToNearestVowelV1} from "../src/Challenge.sol";

contract ChallengeTest is Test {
    DistanceToNearestVowelV1 public challenge;

    function setUp() public {
        challenge = new DistanceToNearestVowelV1();
    }

    function test_challenge() public {
        bool result = challenge.runTest();
        assertEq(result, true);
    }

}
