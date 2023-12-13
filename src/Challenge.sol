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
* @author Carson Case         [carsonpcase@gmail.com]
* Score:                      [537,428]
*/
contract DistanceToNearestVowelV1 {

  string str = "HELLO WORLD, My name is ChatGPT. I am creating the test case for the problem so that we have a benchmark to test our algorithm out on that is longer than just abcdabcd";
  uint[] expected = [1, 0, 1, 1, 0, 1, 1, 0, 1, 2, 3, 4, 5, 4, 3, 2, 1, 0, 1, 0, 1, 0, 1, 2, 2, 1, 0, 1, 2, 3, 3, 2, 1, 0, 1, 0, 1, 2, 2, 1, 0, 0, 1, 0, 1, 2, 3, 2, 1, 0, 1, 1, 0, 1, 2, 2, 1, 0, 1, 0, 1, 1, 0, 1, 2, 2, 1, 0, 1, 2, 1, 0, 1, 1, 0, 1, 2, 1, 0, 1, 2, 1, 0, 1, 2, 1, 0, 1, 1, 0, 1, 0, 1, 0, 1, 1, 0, 1, 2, 2, 1, 0, 1, 2, 2, 1, 0, 1, 1, 0, 1, 2, 1, 0, 0, 1, 1, 0, 1, 1, 0, 1, 0, 1, 2, 2, 1, 0, 0, 1, 1, 0, 1, 2, 2, 1, 0, 1, 1, 0, 1, 2, 1, 0, 1, 1, 0, 1, 2, 2, 1, 0, 1, 2, 1, 0, 1, 2, 1, 0, 1, 2, 1, 0, 1, 2, 3];

  // You may uncomment/modify these for debugging, but do not use these values for your score
  // string str = "abbcdabcd";
  // uint[] expected = [0,1,2,2,1,0,1,2,3];

  /// New algorithm...
  /**
   * 
   * 1. Loop through find 2 vowels indexes as (X, Y)
   * Ex. "Hello" (X = 1, Y = 4)
   * 
   * 2. Find half of the distance between these values as D.
   * Ex. d = 4 - 1 = 3 | D = d/2 = 1
   * 
   * 3. X and Y are 0. For the distance between count up and down after the pivot halfway point, if the haflway value is odd, double the largest count
   * Ex. "ello" = X -> Y = 0110
   */
  function algorithm(string memory _str) internal view returns(uint[] memory){
    bytes memory s = bytes(_str);
    uint sLength = s.length;
    uint sLengthMinus1 = s.length-1;
    uint[] memory result = new uint[](sLength);
    uint x;
    uint y;

    unchecked{
      // first step. If the first character isn't a vowel, count down to the first vowel from the start
      if(isNotVowel(s[x])){
        // find the first vowel with y
        do{
          ++y;
        }while(isNotVowel(s[y]));

        // count x down from y until x = y
        while(x < y){
          result[x] = y - x;
          ++x;
        }
      }

      // Do algorithm until we get to the end of the array
      do{
        // First find the next y or end of the array
        do{
          if(y < sLengthMinus1){
            ++y;
          }else{
            break;
          }
        }while(isNotVowel(s[y]));
        
        // if y has reached the end of the array, count upwards from the last vowel and break
        if(y == sLengthMinus1){
          uint c;
          do{
          result[++x] = ++c;
          }while(x < y);
          
          break;
        }

        // find distance
        uint d = y - x;
        uint D = d/2;

        // set x to 0
        result[x] = 0;

        // Count all the distance starting from step 1 after x
        uint i = 1;
        do{
          
          if(i > D){
            // if > half distance count down
            result[x+i] = result[x+i-1]-1;
          }else{
            // if less than, = half distance, count up
            result[x+i] = i;
          }
          // if equal to half distance on an odd distance, place the next element as the same distance
          if (i == D && d % 2 == 1){
            i++;
            result[x+i] = D;
          }
          ++i;
        }while(i < d);

        // next x is this y
        x = y;

      // end if x becomes the length
      }while(x < sLengthMinus1);
    }


    return result;
  }

  function pyramid(uint numerator, uint denominator) internal pure returns(uint){
    return numerator < denominator  ? numerator : denominator - (numerator % denominator);
  }
  function isNotVowel(bytes1 b) internal pure returns(bool){
    return !(b == 'a' || b == 'e' || b == 'o' || b == 'i' || b == 'u'
          || b == 'O' || b == 'E' || b == 'I' || b == 'A' || b == 'U');
  }

  // function algorithm(string memory _str) internal view returns(uint[] memory){
  //   bytes memory s = bytes(_str);
  //   uint sLength = s.length;
  //   uint[] memory result = new uint[](sLength);
  //   uint i;
  //   unchecked{
  //     // i -> the position of currently evaluating character
  //     do{
  //       // j -> the position of current potential vowel
  //       uint j = i;
  //       uint zigZagCount = 1;
  //       uint counter;
  //       // while character @j != a vowel
  //       while(
  //         !(s[j] == 'a' || s[j] == 'e' || s[j] == 'o' || s[j] == 'i' || s[j] == 'u'
  //         || s[j] == 'O' || s[j] == 'E' || s[j] == 'I' || s[j] == 'A' || s[j] == 'U')
  //       ){
  //         // We need to zig zag relative to i. If i is 5; J must go 4, 6, 3, 7
  //         // BUT cannot zig zag < 0 or > length
  //         if(++counter %2 == 1){
  //           if(i >= zigZagCount){
  //             j = i - zigZagCount;
  //           }

  //         }else{
  //           if (zigZagCount + i < sLength){
  //             j = i + zigZagCount;
  //           }
  //           ++zigZagCount;
  //         }
  //       }
        
  //       result[i] = j < i ?i-j: j-i;
  //       ++i;
  //     }while(i < sLength);
  //   }
  //   return result;
  // }

  function runTest() external view returns(bool){
    return(keccak256(abi.encodePacked(algorithm(str))) == keccak256(abi.encodePacked(expected)));
  }
}
