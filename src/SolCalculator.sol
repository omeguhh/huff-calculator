// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.15;

contract SolCalculator {

    function addTwo(uint256 value1, uint256 value2) public view returns(uint256) {
        return value1 + value2;
    }


    function subTwo(uint256 value1, uint256 value2) public view returns(uint256) {
        return value1 - value2;
    }


    function mulTwo(uint256 value1, uint256 value2) public view returns(uint256) {
        return value1 * value2;
    }


    function divTwo(uint256 value1, uint256 value2) public view returns(uint256) {
        return value1 / value2;
    }

    function modTwo(uint256 value1, uint256 value2) public view returns(uint256) {
        return value1 % value2;
    }

    
}