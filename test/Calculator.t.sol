// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.15;

import "foundry-huff/HuffDeployer.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";
import "../src/SolCalculator.sol";

interface Calculator {
    function addTwo(uint256,uint256) external pure returns(uint256);
    function subTwo(uint256,uint256) external returns(uint256);
    function mulTwo(uint256,uint256) external returns(uint256);
    function divTwo(uint256,uint256) external returns(uint256);
    function modTwo(uint256,uint256) external returns(uint256);
   
}

contract CalculatorTest is Test {
    /// @dev Address of the SimpleStore contract.
    Calculator public calculator;
    SolCalculator public solCalculator;

    /// @dev Setup the testing environment.
    function setUp() public {
        string memory wrappers = vm.readFile("test/mocks/SafeMathWrappers.huff");
        calculator = Calculator(HuffDeployer.deploy_with_code("Calculator", wrappers));
        solCalculator = new SolCalculator();
    }



    /*´:°•.°+.*•´.*:˚.°*.˚•´.°:°•.°•.*•´.*:˚.°*.˚•´.°:°•.°+.*•´.*:*/
    /*                        HUFF Macros                         */
    /*.•°:°.´+˚.*°.˚:*.´•*.+°.•°:´*.´•*.•°.•°:°.´:•˚°.*°.˚:*.´+°.•*/

    /// @dev Ensure that you can set and get the value.
    function testAddHuff(uint256 a, uint256 b) public {
        unchecked {
            uint256 c = a + b;

            if (a > c) {
                vm.expectRevert();
                calculator.addTwo(a, b);
                return;
            } else {
                uint256 answer = calculator.addTwo(a, b);
                assertEq(answer, a+b);
            }
   
        }
    
    }



    function testSubHuff(uint256 a, uint256 b) public {
        a = bound(a,0,2**256-1);
        b = bound(b,0,2**256-1);

        if(b>a) {
            vm.expectRevert();
            calculator.subTwo(a,b);
            return;
        } else {
            uint256 res = calculator.subTwo(a,b);
            assertEq(res, a-b);
            return;
        }
    }

    function testMulHuff(uint256 a, uint256 b) public {
       unchecked {
        uint256 result;
        if(a == 0 || b ==0) {
            result = calculator.mulTwo(a, b);
            assertEq(result, 0);
            return;
        }

        uint256 c = a * b;
        if(c/a != b) {
            vm.expectRevert();
            calculator.mulTwo(a, b);
            return;
        }
            result = calculator.mulTwo(a, b);
            assertEq(result, c);

       }
        
        
    }

    function testDivHuff(uint256 a, uint256 b) public {
       unchecked {
        if(b == 0 || b<0) {
            vm.expectRevert();
            calculator.divTwo(a, b);
            return;
        }
        uint256 c = a/b;
        uint256 res = calculator.divTwo(a, b);
        assertEq(res, c);
       }
        
        
    }
    
    function testModHuff(uint256 a, uint256 b) public {
       unchecked {
        if(b == 0 || b<0) {
            vm.expectRevert();
            calculator.modTwo(a, b);
            return;
        } else {
            uint256 res = calculator.modTwo(a, b);
            assertEq(res, a % b);

        }
    
       
        
       }
        
        
    }

    /*´:°•.°+.*•´.*:˚.°*.˚•´.°:°•.°•.*•´.*:˚.°*.˚•´.°:°•.°+.*•´.*:*/
    /*                        Solidity Methods                      */
    /*.•°:°.´+˚.*°.˚:*.´•*.+°.•°:´*.´•*.•°.•°:°.´:•˚°.*°.˚:*.´+°.•*/

    function testAddSol(uint256 a, uint256 b) public {
  uint256 maxVal = 2**256-1;
        a = bound(a,0,maxVal);
        b = bound(b,0,maxVal-a);
     

        if(a+b> maxVal) {
            vm.expectRevert();
            solCalculator.addTwo(a, b);
            return;
        } else {
            uint256 answer = solCalculator.addTwo(a, b);
        }

       
       
      
    }


    function testSubSol(uint256 a, uint256 b) public {
  uint256 maxVal = 2**256-1;
        a = bound(a,0,maxVal);
        b = bound(b,0,maxVal);

        if(b>a) {
            vm.expectRevert();
            solCalculator.subTwo(a, b);
            return;
        } else {
            uint256 answer = solCalculator.subTwo(a, b);
        }
      

       
       
      
    }


}


