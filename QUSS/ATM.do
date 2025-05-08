vlib work
vlog ATM_Banking_System.v hi_tb.v +cover -covercells
vsim -voptargs=+acc work.ATM_tb -cover
add wave *
coverage save ATM_Banking_System11.ucdb -onexit 
run -all