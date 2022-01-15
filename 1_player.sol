// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.7;

import "./2_character.sol";
import "./3_weapon.sol";
import "./4_armor.sol";
import "./5_shop.sol";

contract Player is Character, Weapon, Armor, Shop {
    uint8 public player_level;
    uint16 public player_score;

    modifier onlyOwner(address _adr){
        require(_adr == owner_address);
        _;
    }

    constructor(string memory _character_name, string memory _character_species, string memory _character_class, string memory _weapon_name){
        character_name = _character_name;
        character_species = _character_species;
        character_class = _character_class;
        weapon_name = _weapon_name;

        health_point = 1000;
        weapon_damage = 69;
        armor_points = 1000;
        player_level = 1;
        player_score = 65535;

    }

    // Функция атаки игрока

    function Player_attack(address enemy_address) public onlyOwner(msg.sender){

        require(health_point > 0, "You are dead");
            require(Player(enemy_address).health_point() > 0, "The player is dead");

                Player enemy = Player(enemy_address);

                if (enemy.armor_points() >= weapon_damage * 20 / 100){
                    enemy.Character_setHealth(weapon_damage * 80 / 100);
                    enemy.Armor_setPoints(weapon_damage * 20 / 100);
                } else {
                    enemy.Character_setHealth(weapon_damage);
                }

                emit Player_battle(msg.sender, enemy_address, weapon_damage, health_point);

                if (enemy.health_point() == 0){
                    player_level += 1;
                    player_score += 10;

                    emit Player_victory(msg.sender, enemy_address, player_level, player_score);
                }                
    }

    // Лечение

    function Player_cure() public onlyOwner(msg.sender){
        require(player_score > 0, "Not enough score");

            health_point += 20;
            player_score -= 3;

            emit Player_healing(msg.sender, health_point);
    }

    // Прокачка оружия

    function Player_improveAttack() public onlyOwner(msg.sender){
        require(player_score > 0, "Not enough score");
        require(weapon_upgr_counter < 5, "Max upgrade");
        require(keccak256(abi.encodePacked(weapon_name)) != keccak256(abi.encodePacked("Shaverma")), "YOU GOT SHAVERMA!!!!!!!!");

            weapon_damage += 2;
            weapon_upgr_counter++;
            player_score -= 5;

            emit Player_smithing(msg.sender, weapon_damage);
    }

    // Починка брони

    function Player_armorFix() public onlyOwner(msg.sender){
        require(player_score > 0, "Not enough score");
        require(wear_counter < 5, "Can not be fixed");

            armor_points = max_armor_points;
            wear_counter++;
            player_score -= 15;

            emit Player_smithing(msg.sender, weapon_damage);
    }

    // Покупка оружия

    function Player_buy_weapon(uint8 _id) public onlyOwner(msg.sender){
        require(player_score >= weapon_shop[_id].product_weapon_cost, "Not enough score");
            weapon_damage = weapon_shop[_id].product_weapon_damage;
            player_score -= weapon_shop[_id].product_weapon_cost;
            weapon_name = weapon_shop[_id].product_weapon_name;
            weapon_upgr_counter = 0;

            emit Player_buying(msg.sender, weapon_shop[_id].product_weapon_name, weapon_shop[_id].product_weapon_cost);

            if (keccak256(abi.encodePacked(weapon_shop[_id].product_weapon_name)) == keccak256(abi.encodePacked("Shaverma"))){
                weapon_shop.pop();
            }

    }
    
    // Покупка брони

    function Player_buy_armor(uint8 _id) public onlyOwner(msg.sender){
        require(player_score >= armor_shop[_id].product_armor_cost, "Not enough score");
            armor_points = armor_shop[_id].product_armor_points;
            max_armor_points = armor_shop[_id].product_armor_points;
            player_score -= armor_shop[_id].product_armor_cost;
            armor_name = armor_shop[_id].product_armor_name;
            wear_counter = 0;
            

            // Заглушка (потом поменяю) =========================================================================================================
            emit Player_buying(msg.sender, armor_shop[_id].product_armor_name, armor_shop[_id].product_armor_cost);
            //===================================================================================================================================
            if (keccak256(abi.encodePacked(armor_shop[_id].product_armor_name)) == keccak256(abi.encodePacked("Shaverma"))){
                armor_shop.pop();
            }

    }
}
