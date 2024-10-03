# 2D Platformer with Player Movement and Camera
This project is a basic 2D platformer developed using the LÖVE framework, incorporating player movement, collision detection, and a camera system. It uses libraries like anim8 for sprite animations, STI for loading tiled maps, and Windfield for managing physics and collision.

## Features
* Player movement: Controlled using the keyboard (WSAD).
* Camera: Follows the player, ensuring smooth scrolling through the map.
* Collision detection: Basic collision using the Windfield library for physics.
* Sprite animations: Player character has walking animations in four directions (up, down, left, right).
* Tiled map rendering: Utilizes STI to load and render a map created in Tiled.

## Libraries Used
* anim8: A simple animation library for LÖVE.
* STI: A Tiled map loader for LÖVE.
* Windfield: A simple 2D physics library for LÖVE.

Installation
Install LÖVE: Download and install the LÖVE framework.

1. Clone or download the project files.
git clone https://github.com/your-repo-url/2d-platformer-project
2. Run the project: Once you have LÖVE installed, navigate to the project folder and run:
love .

## Controls
W: Move up
S: Move down
A: Move left
D: Move right

## How It Works
* Player Movement: The player object moves based on the arrow key inputs. A setLinearVelocity function is used to update the player's velocity, and animations are updated depending on the movement direction.
* Camera: The camera uses the player's position to center the view, while borders prevent the camera from moving beyond the edges of the map.
* Collisions: Windfield handles collision detection between the player and the world, including static objects like walls.
* Tiled Map: The map is loaded from a .lua file exported from Tiled, and different layers (e.g., ground, trees, and houses) are rendered on the screen.

## File Structure
project-directory/
├── libraries/
│   ├── anim8.lua
│   ├── camera.lua
│   ├── sti/
│   └── windfield.lua
├── maps/
│   └── OverWorldFinal.lua  (Exported from Tiled)
├── sprites/
│   ├── character.png       (Sprite sheet for the player character)
│   └── background.png      (Background image)
├── main.lua                (Main game code)

## Future Improvements
1. Add more complex collisions and physics interactions.
2. Implement enemies, items, and other game mechanics.
3. Expand the map to include more areas and challenges.

## License
This project is for educational purposes and is licensed under the MIT License.