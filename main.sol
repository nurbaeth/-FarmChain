// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract FarmChain {
    uint public cropGrowTime = 1 days;

    enum CropType { None, Wheat, Corn }

    struct Crop {
        CropType cropType;
        uint plantedAt;
    }

    mapping(address => Crop) public crops;

    event CropPlanted(address indexed farmer, CropType cropType);
    event CropHarvested(address indexed farmer, CropType cropType);

    function plantCrop(CropType cropType) external {
        require(cropType != CropType.None, "Invalid crop type");
        require(crops[msg.sender].cropType == CropType.None, "Already planted");

        crops[msg.sender] = Crop({
            cropType: cropType,
            plantedAt: block.timestamp
        });

        emit CropPlanted(msg.sender, cropType);
    }

    function harvestCrop() external {
        Crop storage crop = crops[msg.sender];
        require(crop.cropType != CropType.None, "Nothing to harvest");
        require(block.timestamp >= crop.plantedAt + cropGrowTime, "Crop not ready");

        CropType harvested = crop.cropType;
        crops[msg.sender] = Crop(CropType.None, 0);

        emit CropHarvested(msg.sender, harvested);
    }

    function timeLeft() external view returns (uint) {
        Crop memory crop = crops[msg.sender];
        if (crop.cropType == CropType.None) return 0;
        if (block.timestamp >= crop.plantedAt + cropGrowTime) return 0;
        return (crop.plantedAt + cropGrowTime) - block.timestamp;
    }

    function currentCrop() external view returns (CropType, uint) {
        Crop memory crop = crops[msg.sender];
        return (crop.cropType, crop.plantedAt);
    }
}
