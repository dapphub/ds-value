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

pragma solidity >=0.4.23;

import "ds-test/test.sol";
import "./value.sol";

contract TestUser {
    function doPoke(CfgRewardRate value, uint256 wut, uint256 wutAO) public {
        value.poke(wut, wutAO);
    }

    function doVoid(CfgRewardRate value) public {
        value.void();
    }
}

contract CfgRewardRateTest is DSTest {
    CfgRewardRate value;
    uint256 invRR = 0.0042 * 10**27;
    uint256 aoRR = 0.0015 * 10**27;
    TestUser user;

    function setUp() public {
        value = new CfgRewardRate();
        user = new TestUser();
    }

    function testPoke() public {
        value.poke(invRR, aoRR);
    }

    function testFailPoke() public {
        user.doPoke(value, invRR, aoRR);
    }

    function testHas() public {
        uint256 wut; bool has;
        (wut, has,,) = value.peek();
        assertTrue(!has);
        value.poke(invRR, aoRR);
        (wut, has,,) = value.peek();
        assertTrue(has);
    }

    function testPeek() public {
        value.poke(invRR, aoRR);
        uint256 wut; bool has;
        (wut, has,,) = value.peek();
        assertEq(invRR, wut);
    }

    function testRead() public {
        value.poke(invRR, aoRR);
        uint256 wut;
        (wut,) = value.read();
        assertEq(invRR, wut);
    }

    function testFailUninitializedRead() public view {
        uint256 wut;
        (wut,) = value.read();
        wut;
    }

    function testFailUnsetRead() public {
        uint256 wut;
        value.poke(invRR, aoRR);
        value.void();
        (wut,) = value.read();
        wut;
    }

    function testVoid() public {
        value.poke(invRR, aoRR);
        uint256 wut; bool has;
        (wut, has,,) = value.peek();
        assertTrue(has);
        value.void();
        (wut, has,,) = value.peek();
        assertTrue(!has);
    }

    function testFailVoid() public {
        value.poke(invRR, aoRR);
        user.doVoid(value);
    }
}
