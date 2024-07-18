# Console Hangman Game

## Table of Contents
- [Introduction](#introduction)
- [Features](#features)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Usage](#usage)
- [Functions](#functions)
- [Contributing](#contributing)
- [License](#license)
- [Acknowledgements](#acknowledgements)

## Introduction
This project is a console-based Hangman game implemented in assembly language. It includes several features such as clearing the screen, changing background colors, generating random numbers, printing strings, and drawing the hangman character based on the player's guesses.

## Features
- **Home Screen**: Displays a welcome screen with the game's title and team members.
- **Game Loop**: Core loop of the game where the player guesses the letters of a randomly chosen word.
- **Drawing Hangman**: Visual representation of the hangman based on incorrect guesses.
- **Winning and Losing Messages**: Displays appropriate messages based on the player's performance.

## Prerequisites
- An assembler like NASM (Netwide Assembler).
- An emulator like DOSBox to run the assembled code.

## Installation
1. Clone the repository to your local machine:
    ```sh
    git clone <repository-url>
    ```
2. Navigate to the project directory:
    ```sh
    cd console-hangman-game
    ```
3. Assemble the code using NASM:
    ```sh
    nasm -f bin -o hangman.com hangman.asm
    ```

## Usage
1. Run the assembled executable:
    ```sh
    dosbox hangman.com
    ```
2. Follow the on-screen instructions to play the game.

## Functions
### clearScreen
Clears the console screen.

### Change_Background_Color
Changes the background color of the console screen.

### GenRandNum
Generates a random number between 0 and 9.

### printstr
Prints a string on the console screen at a specified position.

### Home_Screen
Displays the home screen with the game's title and team members.

### PrintBorder
Draws a border on the console screen.

### printInputline
Prints the input prompt for the player.

### Draw_Man
Draws the hangman character based on the player's incorrect guesses.

### Print_Charcter
Prints the correctly guessed character in the word.

### Game_Loop
Main game loop where the player guesses letters.

### Print_Died_MSG
Displays the message when the player loses the game.

### PrintWinningMSG
Displays the message when the player wins the game.

### Print_ThankYou
Displays a thank you message after the game ends.

### Play_Again_Choice
Prompts the player to play again.

### ResetGame
Resets the game state for a new game.

## Contributing
Contributions are welcome! Please follow these steps:
1. Fork the repository.
2. Create a new branch (`git checkout -b feature-branch`).
3. Make your changes and commit them (`git commit -m 'Add new feature'`).
4. Push to the branch (`git push origin feature-branch`).
5. Create a new Pull Request.
   

## Acknowledgements
- Thanks to the team members for their contributions to this project.
- Special thanks to the authors of the assembly language book referenced in the code.
