from timeit import default_timer as timer
from mpi4py import MPI
import numpy as np


# Parallel AHS
def alternating_harmonic_series(N,rank,size):
  value = 0
  for n in range(rank+1,N+1,size):
    value+= (-1)**(n+1) / n 
  return value


# Set up MPI
comm = MPI.COMM_WORLD
rank = comm.Get_rank()
size = comm.Get_size()


# Main with timing
start = timer()
N           = 10**8
value       = alternating_harmonic_series(N,rank,size)
send_val    = np.array(value,'d')
value_sum   = np.array(0.0,'d')
comm.Reduce(send_val,value_sum,op=MPI.SUM,root=0)
stop  = timer()


# Output
if rank==0:
  print(' Number of processors: ',size)
  print(' Number of terms in series: ',N)
  print(' Ending value of series: ',value_sum)
  print(' Elapsed time: ',stop-start)
