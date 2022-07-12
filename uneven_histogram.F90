!=======================================================++++++++==========!
! BINNING AND COMPUTING HISTOGRAM/PROBABILITY OF TIME SERIES DATA
! IN THIS CODE A NEW ALGORITH IS USED TO FIND THE INDEX OF CV
! WHICH LANDS ON GRID AND DOSEN'T REQIRE GRID SIZE TO BE EXPLICITLY GIVEN
! WRITTEN BY: Rahul Verma (vrahul@iitk.ac.in)
!=========================================================================!
IMPLICIT NONE
INTEGER :: i,j,n,dummy
INTEGER :: nbin,index1
REAL*8  :: dum,cv(100000),prob(100000),diff(100)
REAL*8  :: gmin,gmax,grid(20),pos(50),s(1000),sum1
REAL*8  :: cut_min, cut_max
REAL*8  :: a,b,x,y,norm
!
! PREDEFINED BINS
nbin = 13
PRINT*,'TOTAL BIN ::',nbin
! VALUES ASSOCIATED TO EACH BIN
pos(1) = 5.0 ; pos(2) = 5.1 ; pos(3) = 5.2 ; pos(4) = 5.3
pos(5) = 5.4 ; pos(6) = 5.5 ; pos(7) = 5.6 ; pos(8) = 5.7
pos(9) = 5.8 ; pos(10) = 5.85 ; pos(11) = 5.9 ; pos(12) = 5.95 ; pos(13) = 6.0
!
OPEN(11,FILE='cvmdck_mtd')
OPEN(12,FILE='new_algo_prob.dat')
! Total Steps in CV file
n = 30000

DO i = 1,n
 READ(11,*)dummy,dummy,dum,dum,dum,dum,dum,dum,dum,cv(i)
! WRITE(6,*)dummy,dummy,dum,dum,dum,dum,dum,dum,dum,cv(i)
END DO

prob=0.0
DO i = 1,n
 DO j = 1,nbin-1
! DECIDING THE RANGE IN WHICH THE INDEX COUNT WILL BE CONSIDERED
  IF (j .eq. 1) THEN
   a = (pos(j+1) - pos(j))/2.0
    cut_min = pos(1) 
    cut_max = pos(1) + 0.04
  ELSEIF (j .gt. 1 .and. j .lt. nbin)THEN
    a = (pos(j+1) - pos(j))/2.0
    b = (pos(j) - pos(j-1))/2.0
    cut_min = pos(j) - a 
    cut_max = pos(j) + a
  ELSEIF (j .eq. nbin) THEN
    b = (pos(j) - pos(j-1))/2.0          
    cut_min = pos(nbin) - b 
    cut_max = pos(nbin)
   EXIT
  ENDIF
! STORE THE INDEX ONLY IF THE CV VALUE IS WITHIN THE DECIDED INDEX (Above)
 IF (cv(i) .ge. cut_min .and. cv(i) .le. cut_max)THEN 
 index1 = j
 ENDIF
 ENDDO 
! BINNING/HISTOGRAMMING
  IF (index1 .gt. 0 .and. index1 .lt. nbin) THEN
  prob(index1) = prob(index1) + 1
  ENDIF
ENDDO
! CALCULATE NORMALIZATION IF NEEDED
DO i = 1,nbin
norm = norm + prob(i)
ENDDO

sum1=0
DO i = 1,nbin
sum1 = sum1+ prob(i)
WRITE(12,*)pos(i),prob(i)
ENDDO
PRINT*,'TOTOAL VISITED POINTS ::',sum1
END
