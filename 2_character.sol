// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.7;

import "./7_dungeon.sol";

contract Character is Dungeon {

    address public owner_address = msg.sender;
    string public character_name;
    string public character_species;
    string public character_class;
    uint16 public health_point;

    event Player_battle(address damage_dealer, address damege_taker, uint16 damage_size, uint16 remaining_health);
    event Player_victory(address winner, address loser, uint8 winner_lvl, uint winner_score);
    event Player_healing(address healer, uint16 remaining_health);
    event Player_smithing(address player, uint16 new_weapon_damage);
    event Player_buying(address player, string item_name, uint16 cost);


    function Character_setHealth(uint16 damage) public {
        if (damage >= health_point){
            health_point = 0;
            is_in_dungeon = false;
        }
        else
            health_point -= damage;
    }
    
}
