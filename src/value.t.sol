// Copyright (C) 2017  DappHub, LLC

// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.

// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.

// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.

pragma solidity ^0.4.23;


import "ds-test/test.sol";
import "./value.sol";

contract TestUser {

    function doPoke(DSValue value, bytes32 wut) public {
        value.poke(wut);
    }

    function doVoid(DSValue value) public {
        value.void();
    }
}

contract DSValueTest is DSTest {

    DSValue value;
    bytes32 data = bytes32("test");
    TestUser user;

    function setUp() public {
        value = new DSValue();
        user = new TestUser();
    }

    function testPoke() public {
        value.poke(data);
    }

    function testFailPoke() public {
        user.doPoke(value, data);
    }

    function testHas() public {
        bytes32 wut; bool has;
        (wut, has) = value.peek();
        assertTrue(!has);
        value.poke(data);
        (wut, has) = value.peek();
        assertTrue(has);
    }

    function testPeek() public {
        value.poke(data);
        bytes32 wut; bool has;
        (wut, has) = value.peek();
        assertEq(data, wut);
    }

    function testRead() public {
        value.poke(data);
        bytes32 wut = value.read();
        assertEq(data, wut);
    }

    function testFailUninitializedRead() public view {
        bytes32 wut = value.read();
        wut;
    }

    function testFailUnsetRead() public {
        value.poke(data);
        value.void();
        bytes32 wut = value.read();
        wut;
    }

    function testVoid() public {
        value.poke(data);
        bytes32 wut; bool has;
        (wut, has) = value.peek();
        assertTrue(has);
        value.void();
        (wut, has) = value.peek();
        assertTrue(!has);
    }

    function testFailVoid() public {
        value.poke(data);
        user.doVoid(value);
    }

}