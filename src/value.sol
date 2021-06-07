/// value.sol - a value is a simple thing, it can be get and set

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

import 'ds-thing/thing.sol';

contract CfgRewardRate is DSThing {

    bool    hasInvestorRewardRate;
    uint256 investorRewardRate;

    bool    hasAORewardRate;
    uint256 aoRewardRate;

    function peek() public view returns (uint256, bool, uint256, bool) {
        return (investorRewardRate, hasInvestorRewardRate, aoRewardRate, hasAORewardRate);
    }
    
    function read() public view returns (uint256, uint256) {
        uint256 wutInvestor; bool hazInvestor; uint256 wutAO; bool hazAO;
        (wutInvestor, hazInvestor, wutAO, hazAO) = peek();
        require(hazInvestor && hazAO, "haz-not");
        return (wutInvestor, wutAO);
    }
    
    function poke(uint256 wut, uint256 wutAO) public note auth {
        investorRewardRate = wut;
        aoRewardRate = wutAO;
        hasInvestorRewardRate = true;
        hasAORewardRate = true;
    }

    function void() public note auth {
        hasInvestorRewardRate = false;
        hasAORewardRate = false;
    }

}
