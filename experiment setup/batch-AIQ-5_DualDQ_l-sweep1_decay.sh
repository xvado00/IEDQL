#!/bin/bash

#
# VARIABLES
#

# Reference machines with parameters to AIQ on
machines=(
BF
)

# Agents with parameters to run AIQ on
agents=(
	DualDQ_l,0.0003,0.99,32,0.01,8000,64,512,0,1,2,1.0,200,0.0,0
	DualDQ_l,0.0003,0.99,32,0.01,4000,64,512,0,1,2,1.0,200,0.0,0
	DualDQ_l,0.0003,0.99,32,0.01,2000,64,512,0,1,2,1.0,200,0.0,0
	DualDQ_l,0.0003,0.99,32,0.01,1000,64,512,0,1,2,1.0,200,0.0,0
	DualDQ_l,0.0003,0.99,32,0.01,500,64,512,0,1,2,1.0,200,0.0,0
	DualDQ_l,0.0003,0.99,32,0.01,250,64,512,0,1,2,1.0,200,0.0,0
	DualDQ_l,0.0003,0.99,32,0.005,8000,64,512,0,1,2,1.0,200,0.0,0
	DualDQ_l,0.0003,0.99,32,0.005,4000,64,512,0,1,2,1.0,200,0.0,0
	DualDQ_l,0.0003,0.99,32,0.005,2000,64,512,0,1,2,1.0,200,0.0,0
	DualDQ_l,0.0003,0.99,32,0.005,1000,64,512,0,1,2,1.0,200,0.0,0
	DualDQ_l,0.0003,0.99,32,0.005,500,64,512,0,1,2,1.0,200,0.0,0
	DualDQ_l,0.0003,0.99,32,0.005,250,64,512,0,1,2,1.0,200,0.0,0
	DualDQ_l,0.0003,0.99,32,0.001,8000,64,512,0,1,2,1.0,200,0.0,0
	DualDQ_l,0.0003,0.99,32,0.001,4000,64,512,0,1,2,1.0,200,0.0,0
	DualDQ_l,0.0003,0.99,32,0.001,2000,64,512,0,1,2,1.0,200,0.0,0
	DualDQ_l,0.0003,0.99,32,0.001,1000,64,512,0,1,2,1.0,200,0.0,0
	DualDQ_l,0.0003,0.99,32,0.001,500,64,512,0,1,2,1.0,200,0.0,0
	DualDQ_l,0.0003,0.99,32,0.001,250,64,512,0,1,2,1.0,200,0.0,0
)

# Episode lenghts to test with
episodes=(
100000
)

# Sample size to test with
samples=(
2000
)

# CPU threads to use
threads=16

# Batch AIQ log file
batch_log=batch-AIQ-5_DualDQ_l_sweep1-decay.log

#
# MAIN SCRIPT
#

# Check for log directory
if [ ! -d log ]; then
	mkdir log
fi

# Check for log EL directory
if [ ! -d log-el ]; then
	mkdir log-el
fi
# Check for samples directory
if [ ! -d adaptive-samples ]; then
	mkdir adaptive-samples
fi

echo "`date +%F-%T`: Batch AIQ started on `hostname` using ${threads} threads." >> ${batch_log}
# For each machine, agent, episode lenght and sample size 
# test AIQ and log results
for _machine in ${machines[@]}
do
	for _agent in ${agents[@]}
	do
		for _episode in ${episodes[@]}
		do
			for _sample in ${samples[@]}
			do

			echo "`date +%F-%T`: Started round (${_machine}:${_agent}:${_episode}:${_sample})." >> ${batch_log}

			python3 AIQ.py --log --verbose_log_el --log_agent_failures -t "${threads}" -r "${_machine}" -a "${_agent}" -l "${_episode}" -s "${_sample}"

			echo "`date +%F-%T`: Ended round (${_machine}:${_agent}:${_episode}:${_sample})." >> ${batch_log}

			done
		done
	done
done
echo "`date +%F-%T`: Batch AIQ ended." >> ${batch_log}
