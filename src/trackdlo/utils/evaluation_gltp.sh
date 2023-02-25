#!/bin/bash
# Loop

for bag in 0
do
    for pct in 50 75
    do
        for trial in 0 1 2 3 4 5 6 7 8 9
        do
            for alg in gltp
            do
                terminator -e "cd rmdlo_tracking && source devel/setup.bash && roslaunch trackdlo gltp.launch" &
                first_terminal=$!
                terminator -e "cd rmdlo_tracking && source devel/setup.bash && roslaunch trackdlo evaluation.launch alg:=$alg bag_file:=$bag trial:=$trial pct_occlusion:=$pct --wait" &
                second_teminal=$!
                sleep 80
                rosnode kill -a
                killall -9 rosmaster
            done
        done
    done
done

for bag in 1 2
do
    for trial in 0 1 2 3 4 5 6 7 8 9
    do
        for alg in gltp
        do
            terminator -e "cd rmdlo_tracking && source devel/setup.bash && roslaunch trackdlo gltp.launch" &
            first_terminal=$!
            terminator -e "cd rmdlo_tracking && source devel/setup.bash && roslaunch trackdlo evaluation.launch alg:=$alg bag_file:=$bag trial:=$trial pct_occlusion:=0 --wait" &
            second_teminal=$!
            sleep 80
            rosnode kill -a
            killall -9 rosmaster
        done
    done
done