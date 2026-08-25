// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract LandRegistry {

    address public registrar;
    uint256 public propertyCount;

    struct Property {
        uint256 id;
        string location;
        uint256 area;
        string propertyType;
        address owner;
        bool verified;
        bool active;
    }

    struct OwnershipRecord {
        address previousOwner;
        address newOwner;
        uint256 timestamp;
    }

    mapping(uint256 => Property) public properties;

    mapping(uint256 => OwnershipRecord[]) private ownershipHistory;

    event PropertyRegistered(
        uint256 indexed propertyId,
        address indexed owner
    );

    event PropertyVerified(
        uint256 indexed propertyId
    );

    event OwnershipTransferred(
        uint256 indexed propertyId,
        address indexed previousOwner,
        address indexed newOwner
    );

    constructor() {
        registrar = msg.sender;
        propertyCount = 0;
    }

    modifier onlyRegistrar() {
        require(
            msg.sender == registrar,
            "Only registrar can perform this action"
        );
        _;
    }

    modifier propertyExists(uint256 propertyId) {
        require(
            propertyId > 0 && propertyId <= propertyCount,
            "Property does not exist"
        );
        _;
    }

    function registerProperty(
        string memory _location,
        uint256 _area,
        string memory _propertyType,
        address _owner
    )
        public
        onlyRegistrar
        returns (uint256)
    {
        require(_area > 0, "Area must be greater than zero");
        require(_owner != address(0), "Invalid owner address");

        propertyCount++;

        properties[propertyCount] = Property({
            id: propertyCount,
            location: _location,
            area: _area,
            propertyType: _propertyType,
            owner: _owner,
            verified: false,
            active: true
        });

        emit PropertyRegistered(
            propertyCount,
            _owner
        );

        return propertyCount;
    }

    function verifyProperty(
        uint256 _propertyId
    )
        public
        onlyRegistrar
        propertyExists(_propertyId)
    {
        properties[_propertyId].verified = true;

        emit PropertyVerified(_propertyId);
    }

    function transferOwnership(
        uint256 _propertyId,
        address _newOwner
    )
        public
        propertyExists(_propertyId)
    {
        require(
            properties[_propertyId].owner == msg.sender,
            "Only current owner can transfer"
        );

        require(
            _newOwner != address(0),
            "Invalid new owner"
        );

        address previousOwner =
            properties[_propertyId].owner;

        properties[_propertyId].owner = _newOwner;

        ownershipHistory[_propertyId].push(
            OwnershipRecord({
                previousOwner: previousOwner,
                newOwner: _newOwner,
                timestamp: block.timestamp
            })
        );

        emit OwnershipTransferred(
            _propertyId,
            previousOwner,
            _newOwner
        );
    }

    function deactivateProperty(
        uint256 _propertyId
    )
        public
        onlyRegistrar
        propertyExists(_propertyId)
    {
        properties[_propertyId].active = false;
    }

    function getProperty(
        uint256 _propertyId
    )
        public
        view
        propertyExists(_propertyId)
        returns (
            uint256,
            string memory,
            uint256,
            string memory,
            address,
            bool,
            bool
        )
    {
        Property memory p = properties[_propertyId];

        return (
            p.id,
            p.location,
            p.area,
            p.propertyType,
            p.owner,
            p.verified,
            p.active
        );
    }

    function getOwnershipHistory(
        uint256 _propertyId
    )
        public
        view
        propertyExists(_propertyId)
        returns (OwnershipRecord[] memory)
    {
        return ownershipHistory[_propertyId];
    }

    function getRegistrar()
        public
        view
        returns (address)
    {
        return registrar;
    }
}