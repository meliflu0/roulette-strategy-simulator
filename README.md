# roulette-strategy-simulator
Console-based Roulette Simulator that allows users to play the Par or Impar game.  Includes implementation of two betting strategies: Martingale and Inverse Labouchere.  Designed for experimentation with betting strategies and probability analysis, fully playable through the command line.

## Features:
- Play Par or Impar in roulette
- Apply Martingale or Inverse Labouchere strategies
- Track wins and losses
- Fully console-based, no GUI required
- Written in Bash for Linux terminals

## Usage:
- Run the script: ./ruleta.sh
- Roulette parameters:
- -h  display the help panel
- -m  amount of money you want to bet
- -t  strategy you want to use

## Examples:

- Displays the help panel
- ./ruleta.sh -h

- Play with $1000 using the Martingale strategy
- ./ruleta.sh -m 1000 -t martingala

## Note:

- Currently, all output messages are in Spanish. An English version is planned. Contributions welcome!

