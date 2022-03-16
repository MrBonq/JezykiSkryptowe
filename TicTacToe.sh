#!/usr/bin/bash

player_1="X"
player_2="O"

turn=1
game_on=true

moves=(1 2 3 4 5 6 7 8 9)

print_board(){
    clear
    echo " ${moves[0]} | ${moves[1]} | ${moves[2]}"
    echo "-----------"
    echo " ${moves[3]} | ${moves[4]} | ${moves[5]}"
    echo "-----------"
    echo " ${moves[6]} | ${moves[7]} | ${moves[8]}"
}

player_move(){
    if [[ $(($turn % 2)) == 0 ]]
    then
        echo "player one turn:"
        while [[ $(($turn % 2)) == 0 ]]
        do
            read square
            if [[ ${moves[($square -1)]} == $square ]]
            then
                moves[($square -1)]=$player_1
                ((turn=turn+1))
            else
                echo "No a valid square, try again"
            fi
        done
    else
        echo "player two turn"
        while [[ $(($turn % 2)) != 0 ]]
        do
            read square
            if [[ ${moves[($square -1)]} == $square ]]
            then
                moves[($square -1)]=$player_2
                ((turn=turn+1))
            else
                echo "No a valid square, try again"
            fi
        done
    fi

}


check_match(){
    if [[ ${moves[$1]} == ${moves[$2]} ]]&&[[ ${moves[$2]} == ${moves[$3]} ]]; then
        game_on=false
    fi
    if [ $game_on == false ]; then
        if [ ${moves[$1]} == 'X' ]; then
            echo "Player one wins!"
            return
        else
            echo "player two wins!"
            return
        fi
    fi
}

check_winner(){
    if [ $game_on == false ]; then return; fi
    check_match 0 1 2
    if [ $game_on == false ]; then return; fi
    check_match 3 4 5
    if [ $game_on == false ]; then return; fi
    check_match 6 7 8
    if [ $game_on == false ]; then return; fi
    check_match 0 4 8
    if [ $game_on == false ]; then return; fi
    check_match 2 4 6
    if [ $game_on == false ]; then return; fi
    check_match 0 3 6
    if [ $game_on == false ]; then return; fi
    check_match 1 4 7
    if [ $game_on == false ]; then return; fi
    check_match 2 5 8
    if [ $game_on == false ]; then return; fi

    if [ $turn -gt 9 ]; then
        $game_on = false
        echo "It's a draw!"
    fi
}

print_board
while $game_on
do
    player_move
    print_board
    check_winner
done