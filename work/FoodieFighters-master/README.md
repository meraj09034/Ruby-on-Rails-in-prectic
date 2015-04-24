FoodieFighters
==============

FoodieFighters - Webserver API for CIS219 class project - Health Fighters

Created By:  
Dave Jones  
Spokane Community College  
[http://youtube.com/lockersoft](http://youtube.com/lockersoft/)  

Concept By:  
Doug Thomson  
Dave Jones  

API controls the Health Fighters from various clients that are initially built in
Android mobile devices.

Clients interact with the Fighting server through an established API.
The server performs the fights and provides storage and statistics.

## Models
  
### User Model

    All the Devise Gem fields

    avatar_name
    avatar_image

    race
    intelligence
    stamina
    agility
    strength

    selected_armor     :has_one  :armor
    selected_weapon    :has_one  :weapon

    max_hit_points
    current_hit_points
    level
    coins
    battles_won
    battles_lost

### Accessories Model
    type            (Single Table Inheritance)
    name
    description
    price

### Weapon Model &lt; Accessories
    damage_points

### Armor Model &lt; Accessories
    save_points

### Fight Model
    users  :has_many users
    winner
    awarded_coins
    description   (Full description of damage inflicted/received,stamina lost, winner, coins, etc.)

### Tournaments ???

### Store Controller (Accessories)

### Game Clients
    name
    author
    description
    site_url
    help_url
    apk_file
    iOS_file
    windows_exe

