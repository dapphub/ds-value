/// a value is a simple thing, it can be get and set

// Copyright (C) 2017  DappHub, LLC

// Licensed under the Apache License, Version 2.0 (the "License").
// You may not use this file except in compliance with the License.

// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND (express or implied).

import 'ds-thing/thing.sol';

contract DSValue is DSThing {
    bool    haz;
    bytes32 val;
    function has() constant returns (bool) {
        return haz;
    }
    function get() constant returns (bytes32) {
        assert(has());
        return val;
    }
    function set(bytes32 wut) auth {
        val = wut;
        haz = true;
    }
    function nil() auth { // unset the value
        haz = false;
    }
}
