// SPDX-License-Identifier: GPL-3.0
pragma solidity >= 0.8.7;

contract Shop {

    struct Product_weapon {
        string product_weapon_name;
        uint16 product_weapon_damage;
        uint16 product_weapon_cost;
        uint8 id;
    }

    struct Product_armor {
        string product_armor_name;
        uint16 product_armor_points;
        uint16 product_armor_cost;
        uint8 id;
    }

    Product_weapon[] public weapon_shop;
    Product_armor[] public armor_shop;
    

    constructor(){

        weapon_shop.push(Product_weapon(0, "Ret", 85, 64));
        weapon_shop.push(Product_weapon(1, "Oret", 100, 100)); 
        weapon_shop.push(Product_weapon(2, "Kret", 125, 143)); 
        weapon_shop.push(Product_weapon(3, "Tret", 150, 178)); 
        weapon_shop.push(Product_weapon(4, "Bret", 175, 214)); 
        weapon_shop.push(Product_weapon(5, "Qret", 200, 257)); 
        weapon_shop.push(Product_weapon(6, "Lret", 225, 291)); 
        weapon_shop.push(Product_weapon(7, "Nret", 250, 368));
         
        weapon_shop.push(Product_weapon(8, "Shaverma", 65535, 65535));

        armor_shop.push(Product_armor(0, "Ret", 50, 64));
        armor_shop.push(Product_armor(1, "Oret", 75, 100)); 
        armor_shop.push(Product_armor(2, "Kret", 100, 143)); 
        armor_shop.push(Product_armor(3, "Tret", 125, 178)); 
        armor_shop.push(Product_armor(4, "Bret", 150, 214)); 
        armor_shop.push(Product_armor(5, "Qret", 175, 257)); 
        armor_shop.push(Product_armor(6, "Lret", 225, 291)); 
        armor_shop.push(Product_armor(7, "Nret", 225, 368));
         
        armor_shop.push(Product_armor(8, "Shaverma", 65535, 65535)); 

    }


    function View_weapon_shop () external view returns(Product_weapon[] memory) {
        return weapon_shop;
    }

    function View_armor_shop () external view returns(Product_armor[] memory) {
        return armor_shop;
    }


}
