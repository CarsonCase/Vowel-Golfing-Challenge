// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/console.sol";

/**
* Distance to Nearest Vowel Solidity Golfing Challenge
*=====================================================
* Write a function that takes in the following string (str) and for each character returns the distance to the nearest vowel (a, e, i, o and u)
* If the character is a vowel itself, return 0. Assume all strings have at least 1 vowel.
* 
* Example:
* IN: "abcdabcd"
* OUT: [0,1,2,1,0,1,2,3]
*
*
* - The algorithm must work for all strings, not only the test string, this includes capital vowels.
* - You may not modify any of this contract except inside the algorithm() function.
* - Call the provided runTest() function and to complete the challenge it must return "true".
* - Run `forge test` to instantly test with Foundry and get your final gas score.
* - Ex Foundry output:
*
*     [PASS] test_challenge() (gas: XXXX)
*
* - List the gas cost of your forge test bellow with your name/twitter/email ect.
* - Post your result on Twitter and tag the challenge @author @SolContractADay.
*
* @author Your Name         [YourName@gmail.com]
* Score:                    []
*/
contract DistanceToNearestVowelV1 {

  string str = "HELLO WORLD, My name is ChatGPT. I am creating the test case for the problem so that we have a benchmark to test our algorithm out on that is longer than just abcdabcd";
  uint[] expected = [1, 0, 1, 1, 0, 1, 1, 0, 1, 2, 3, 4, 5, 4, 3, 2, 1, 0, 1, 0, 1, 0, 1, 2, 2, 1, 0, 1, 2, 3, 3, 2, 1, 0, 1, 0, 1, 2, 2, 1, 0, 0, 1, 0, 1, 2, 3, 2, 1, 0, 1, 1, 0, 1, 2, 2, 1, 0, 1, 0, 1, 1, 0, 1, 2, 2, 1, 0, 1, 2, 1, 0, 1, 1, 0, 1, 2, 1, 0, 1, 2, 1, 0, 1, 2, 1, 0, 1, 1, 0, 1, 0, 1, 0, 1, 1, 0, 1, 2, 2, 1, 0, 1, 2, 2, 1, 0, 1, 1, 0, 1, 2, 1, 0, 0, 1, 1, 0, 1, 1, 0, 1, 0, 1, 2, 2, 1, 0, 0, 1, 1, 0, 1, 2, 2, 1, 0, 1, 1, 0, 1, 2, 1, 0, 1, 1, 0, 1, 2, 2, 1, 0, 1, 2, 1, 0, 1, 2, 1, 0, 1, 2, 1, 0, 1, 2, 3];

  // You may uncomment/modify these for debugging, but do not use these values for your score
  // string str = "abcdabcd";
  // uint[] expected = [0,1,2,1,0,1,2,3];

  function algorithm(string memory _str) internal view returns(uint[] memory){
    bytes memory s = bytes(_str);
    uint[] memory result = new uint[](s.length);
    // i -> the position of currently evaluating character
    for(uint i; i < s.length; i++){
      // j -> the position of current potential vowel
      uint j = i;
      uint zigZagCount = 1;
      uint counter = 1;
      // while character @j != a vowel
      while(
        s[j] != 'a' && s[j] != 'e' && s[j] != 'i' && s[j] != 'o' && s[j] != 'u'
        &&
        s[j] != 'A' && s[j] != 'E' && s[j] != 'I' && s[j] != 'O' && s[j] != 'U'
      ){
        // We need to zig zag relative to i. If i is 5; J must go 4, 6, 3, 7
        // BUT cannot zig zag < 0 or > length
        // todo: needs to increase zigZag every OTHER run regardless of if bound is reached
        if(counter++ %2 == 1){
          if(i >= zigZagCount){
            j = i - zigZagCount;
          }
        }else{
          if (zigZagCount + i < s.length){
            j = i + zigZagCount;
          }
          ++zigZagCount;
        }
      }
      console.log(i>=j ? i-j: j-i);
      result[i] = i>=j ? i-j: j-i;
    }
    return result;

  }

  function runTest() external view returns(bool){
    return(keccak256(abi.encodePacked(algorithm(str))) == keccak256(abi.encodePacked(expected)));
  }
}
