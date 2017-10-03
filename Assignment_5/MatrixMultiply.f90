program MatrixMultiply

implicit none

integer :: n
integer :: i,j,x,y
real(8), dimension(:,:), allocatable :: A,B,C
real(8) :: t1,t2,time


write(*,*)'Input integer matrix size, n:'
read(*,*)n


allocate(A(n,n))
allocate(B(n,n))
allocate(C(n,n))
A=1.
B=1.

call cpu_time(t1)
do i=1,n
   do j=1,n
      C(i,j)=sum(A(i,:)*B(:,j))
   enddo
enddo
call cpu_time(t2)

time = t2-t1


75 format(A,i0,A,ES9.3,A)
write(*,75)'size n = ',n,' matrix multiplication in ',time,' seconds'


open (unit = 1, file = 'C.txt')
do i=1,min(10,n)
   write(1,*)C(i,1:min(5,n))
enddo

end program MatrixMultiply
