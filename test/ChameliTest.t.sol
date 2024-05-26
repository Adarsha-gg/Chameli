// SPDX-License-Identifier: MIT

pragma solidity ^0.8.16;

import {Test} from "../lib/forge-std/src/Test.sol";
import {Chameli} from "../src/ChameliToken.sol";
import {DeployChameli} from "../script/DeployToken.s.sol";

contract ChameliTester is Test {
    Chameli public chameli;
    DeployChameli public deployChameli;

    address bob = makeAddr("bob");
    address mina = makeAddr("mina");
    address alice = makeAddr("alice");

    uint256 public constant MONI = 500 ether;

    function setUp() public {
        deployChameli = new DeployChameli();
        chameli = deployChameli.run();
        vm.prank(msg.sender);
        chameli.transfer(bob, MONI);
    }

    function testBalance() public {
        assertEq(chameli.balanceOf(bob), MONI);
    }

    function testAllowance() public {
        uint256 testAllowance = 100;
        vm.prank(bob);
        chameli.approve(mina, testAllowance);
        assertEq(chameli.allowance(bob, mina), testAllowance);

        vm.prank(mina);
        chameli.transferFrom(bob, mina, 40);
        assertEq(chameli.balanceOf(mina), 40);
        assertEq(chameli.balanceOf(bob), MONI - 40);
        assertEq(chameli.allowance(bob, mina), testAllowance - 40);
    }

    function testTransfer() public {
        uint256 transferAmount = 50 ether;
        vm.prank(bob);
        chameli.transfer(mina, transferAmount);
        assertEq(chameli.balanceOf(mina), transferAmount);
        assertEq(chameli.balanceOf(bob), MONI - transferAmount);
    }

    function testTransferInsufficientBalance() public {
        uint256 transferAmount = MONI + 1 ether;
        vm.prank(bob);
        vm.expectRevert();
        chameli.transfer(mina, transferAmount);
    }

    function testTransferFromInsufficientAllowance() public {
        uint256 allowanceAmount = 100;
        uint256 transferAmount = allowanceAmount + 1;

        vm.prank(bob);
        chameli.approve(mina, allowanceAmount);

        vm.prank(mina);
        vm.expectRevert();
        chameli.transferFrom(bob, mina, transferAmount);
    }

}
