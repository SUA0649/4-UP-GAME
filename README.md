# 4 UP GAME
 Computer Organization and Assembly Language Lab Project done in our 3rd Semester at FAST NUCES KHI  
 **Instructor: Mubashir**

 **Members**: Shaheer Uddin Ahmed(23K-0649),Faizan Jawed(23K-0688),Yahya Shaikh(23K-0718).  
 https://youtu.be/w4Sk5TYWdi4?si=z31NGLrWPZ8H3D-o

# Main Game:
 <a href="https://youtu.be/w4Sk5TYWdi4?si=z31NGLrWPZ8H3D-o" target="_blank">
        <img src="http://img.youtube.com/vi/w4Sk5TYWdi4/maxresdefault.jpg" alt="Watch the video" width="900" height="500" border="10" />
    </a>
</a>
_______________________________________
## Introduction:
Four-Up game is basically a strategy board game consisting of two-players where each player takes turn dropping coins into the vertical grid. First to get 4 coins in a row, either vertically, horizontally or diagonally is declared the winner.

This project aims to implement a simplified version of the Four-Up game in a digital layout using Assembly Language, our main goal is to understand the basics of low-level programming and get a deeper connection to memory management.
________________________________________
## How To Configure:
<a href="https://youtu.be/ZL6BTrsAc_s?si=ND1r3TwFB29mdMCU" target="_blank">
        <img src="http://img.youtube.com/vi/ZL6BTrsAc_s/maxresdefault.jpg" alt="Watch the video" width="900" height="500" border="10" />
</a>
 ______________________________________________

 ## Existing System:
There have been various versions of this game written in numerous high-level programming languages, such as C++, Python, or Java. They mainly use and take advantage of pre-defined complex libraries along with the usage of built-in GUIs (Graphical User Interfaces) such as SFML and Unity which greatly simplifies the process. The existing systems do not give the user or developer insight into memory handling, registers, and CPU-level execution, which could be valuable for educational purposes.
________________________________________
## Proposed Solution:
This proposal focuses on developing the Four-Up Game in Assembly Language, using low-level programming to simulate the game on a virtual interface. The game will be purely text based and will operate within the console environment. By utilizing direct memory access, the game should efficiently manage the player inputs, overall logic, and the game board. Player will have alternating turns to place their discs which will be shown on the console as a grid, with straightforward victory conditions that require connecting four coins in a row in any manner.

This **project** will emphasize:
•	Memory efficient design by limiting the use of external libraries and relying more on registers and stack.
•	Register manipulation for handling inputs and outputs.
•	Optimization of game logic using Assembly constructs.
•	ASCII characters will be used to display the game board and its different elements.
________________________________________

Problem Statement:
Implementing a two-player Four-Up Game using Assembly Language poses significant challenges. These include managing player inputs, rendering a grid-based game board, determining the winning condition, and handling the logic flow of the game—all while staying within the constraints of low-level programming. We aim to demonstrate how complex systems like how board games can be built from the ground up, offering insights into efficient computation, memory usage, and real-time system management.
________________________________________
 
Salient Features:
1.	**Two-Player Turn-Based Gameplay**: The game will support two players who take turns placing discs into the grid, with visual feedback using ASCII characters.
2.	**Board Representation**: The 6x7 game board will be represented as a 2D array stored in memory, with updates made after every move.
3.	**Input Mechanism**: A simple input mechanism will be adopted in which the current player will input their move by specifying the column in which they wish to place their disc. We will be utilizing arrays for this endeavor. The Assembly program will handle the logic to place the disc in the correct row.
4.	**Win Detection**: The game will include logic to check for four consecutive discs horizontally, vertically, or diagonally, determining the winner in real time.
5.	**Memory Optimization**: Efficient use of registers and stack operations to manage game state, minimizing memory overhead.
6.	**Game Restart and Exit Options**: After the game ends, players can choose to either restart the game or exit the program.
7.	**Customization(optional)**: At the start of the game we will allow players to choose their preference of concurrency meaning whether they want to achieve 4,5,6,7 diagonally in order to win the game.
8.	**Real-Time Updates**: The game board will update after every move, displaying the current state of play to both players.
________________________________________

Tools and Technologies:
1.	**Assembler**: The game will be developed using an assembler such as MASM (Microsoft Macro Assembler).
2.	**Library**: Irvine32 library will be used for basic input/output functions, like reading and writing strings and characters on the console respectively.
3.	**Debugger**: Visual Studio’s Microsoft Visual Studio Debugger will be used.
4.	**Registers and Memory Management**: The game will heavily rely on managing the stack, registers (AX, BX, CX, DX, etc.), and memory to perform operations such as storing the board, checking for win conditions, and handling inputs.
5.	**Version Control**: We will use GitHub to display the timeline of our project and how much time it took for the project completion.
