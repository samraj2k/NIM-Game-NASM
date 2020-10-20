# NIM-Game-NASM
NIM Game Program in Assembly Language (NASM) on Linux for two players.

In this there will be 10 piles with each containing some stones.

Two players play with game in alternate moves. In each move one can remove certain positive number of stones from the one of the pile.

The player who cannot remove any stone during his/her move will lose (i.e. all the piles are empty)

Note: The number of stones cannot be negative.

Read more about NIM Game: https://en.wikipedia.org/wiki/Nim

## Compile Instructions:
### Compile with instructions:

nasm –f elf NIMGame.asm

ld –m elf_i386 NIMGame.o –o NIMGame io.o

### Run:

./NIMGame

### Thank You,
### Sameer Raj

