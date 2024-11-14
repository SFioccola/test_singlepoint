#!/bin/bash
NAME="nmr"
molecule=methane
natoms=1
atoms=("null" "C")
cart=("null" "x" "y" "z")


for i in 1
do
for DIR in 1 
do
	base=${molecule}_${atoms[$i]}$i${cart[$DIR]}
	cat > ${base}.in << EOF



&input_qeconverse
        prefix = 'ch4'
        outdir = './scratch/'
        diagonalization = 'david'
        verbosity = 'high'
        q_gipaw = 0.01
        dudk_method = 'singlepoint'
        mixing_beta = 0.5
        lambda_so(1) = 0.0
        m_0(${DIR}) = 1.0
        m_0_atom = ${i}
/
EOF

mpirun -np 6 /home/sfioccola/Desktop/test_singlepoint/QE-CONVERSE/bin/qe-converse.x < ${base}.in > ${base}.out

done
done

