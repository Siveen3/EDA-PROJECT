vlib work
vlog ATM_Banking_System.v ATM_Banking_System_tb.v +cover
vsim -voptargs=+acc work.ATM_TB -cover
add wave*
coverage save ATM_TB_db.ucdb -onexit -du ATM
run -all
