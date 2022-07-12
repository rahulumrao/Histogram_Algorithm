!================================================================!
! BINNING AND COMPUTING HISTOGRAM/PROBABILITY OF TIME SERIES DATA
! THIS CODE ONLY WORKS IF THE 'GRID SIZE' IN EVEN
! WRITTEN BY: Rahul Verma (vrahul@iitk.ac.in)
!================================================================!
IMPLICIT NONE
INTEGER :: i,j,n,dummy
INTEGER :: nbin,index1
REAL*8  :: dum,cv(100000),prob(100000)
REAL*8  :: gmin,gmax,grid(20),pos(50),s(1000),sum1
!
!gridmin ; gridmax  ; griddiff
gmin=5.0 ; gmax=6.0 ; grid(1)=0.1
! Calculating total number of Bins
nbin = NINT((gmax - gmin)/grid(1)) + 1
PRINT*,'TOTAL BIN ::',nbin
!
OPEN(11,FILE='cvmdck_mtd')
OPEN(12,FILE='old_code_prob.dat')
! Total Steps in CV file
n = 30000
!
DO i = 1,n
 READ(11,*)dummy,dummy,dum,dum,dum,dum,dum,dum,dum,cv(i)
! WRITE(6,*)dummy,dummy,dum,dum,dum,dum,dum,dum,dum,cv(i)
END DO
!
prob=0.0
DO i = 1,n
! Finding index at which CV land and binning/histogramming
  index1 = NINT((cv(i) - gmin)/grid(1)) + 1
  IF (index1 .gt. 0 .and. index1 .lt. nbin) THEN
  prob(index1) = prob(index1) + 1
  ENDIF
ENDDO
sum1=0
DO i = 1,nbin
s(i) = FLOAT(i-1)*grid(1) + gmin
sum1 = sum1+ prob(i)
WRITE(12,*)s(i),prob(i)
ENDDO
PRINT*,'TOTOAL VISITED POINTS ::',sum1
END 
