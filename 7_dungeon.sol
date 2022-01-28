// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.7;

contract Dungeon {

    bool public is_in_dungeon;

    struct Dungeon_monsters {
        uint8 id;
        uint16 monster_damage;
        uint16 monster_health_points;
    }

    Dungeon_monsters[] private monsters;

    Dungeon_monsters public current_monster;

    constructor(){

        monsters.push(Dungeon_monsters(0, 100, 300));
        monsters.push(Dungeon_monsters(1, 250, 200)); 
        monsters.push(Dungeon_monsters(2, 225, 225)); 


    }
    
    function monsters_generator() private {
        uint hashBlock = uint(blockhash(block.number - 1));
        uint hashAdr = uint(keccak256(abi.encode(msg.sender)));
        uint hashTime = uint(keccak256(abi.encode(block.timestamp)));

        uint8 res = uint8(uint(keccak256(abi.encode(hashBlock % 1000 + hashAdr % 1000 + hashTime % 1000))) % 3);

        current_monster = monsters[res];

    }

    function monster_attack(uint16 _players_weapon_damage) public{

        if (current_monster.monster_health_points <= 0)
            monsters_generator();

        if (_players_weapon_damage > current_monster.monster_health_points){
            current_monster.monster_health_points = 0;

        } 
        else {
            current_monster.monster_health_points -= _players_weapon_damage;
        }

                        
    }

}
