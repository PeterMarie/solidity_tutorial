// SPDX-License-Identifier: MIT

pragma solidity >=0.6.0 < 0.9.0;

import "./simplestorage.sol";

contract storageFactory is SimpleStorage {

    SimpleStorage[] public simplestoragearray;

    function createSimpleStorage() public {
        SimpleStorage simplestorage = new SimpleStorage();
        simplestoragearray.push(simplestorage);
    }

    function sfstore(uint _simplestoragearrayindex, uint _simplestoragenumber) public {
        SimpleStorage(address(simplestoragearray[_simplestoragearrayindex])).store(_simplestoragenumber);
    }

    function sfretrieve(uint _simplestoragearrayindex) public view returns(uint){
        return SimpleStorage(address(simplestoragearray[_simplestoragearrayindex])).retrieve();
    }
}
