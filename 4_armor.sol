// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.7;

contract Armor {
    string public armor_name;
    uint16 public armor_points;
    uint16 public max_armor_points;
    uint8 public wear_counter;

    function Armor_setPoints(uint16 damage) external {
        armor_points -= damage;
    }
}
