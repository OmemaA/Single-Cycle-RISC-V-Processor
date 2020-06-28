vlog *.v
vsim -novopt work.tb
view wave

add wave sim:/tb/processor/dm/data_mem
add wave sim:/tb/processor/rf/Registers

add wave sim:/tb/*
add wave sim:/tb/processor/*
add wave sim:/tb/processor/*

run 2000ns