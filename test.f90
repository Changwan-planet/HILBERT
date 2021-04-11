PROGRAM test
USE md_hilbert

IMPLICIT NONE



INTEGER, PARAMETER :: S = 4096
REAL*8, DIMENSION(0:S-1) :: xreal
!REAL*8, DIMENSION(0:S-1) :: ximag
COMPLEX*8, DIMENSION(0:S-1) :: a_signal

REAL*8, PARAMETER :: pi = ACOS(-1.0)

INTEGER :: f, t, i

!  OPEN (10, FILE = "/home/changwan/GPR/A_SCOPE_GPR.txt", STATUS="OLD", FORM="FORMATTED", ACTION="READ")
  OPEN (20, FILE =  "/home/changwan/HILBERT/HILBERT_output.txt",  STATUS="REPLACE",  ACTION="WRITE")


!read the RAW gpr data
!READ(10,*) xreal
 

!  xreal=xreal-SUM(xreal)/SIZE(xreal)

  !PRINT*, SUM(xreal)/SIZE(xreal)


!  DO i = 0,S-1
!     PRINT*, xreal(i)
!  END DO


!make a simple signal
f = 1
!ximag = 0.0
DO t=0, S-1
   xreal(t)=COS(2*pi*f*t/(S-1))
END DO
DO i=0, S-1
   PRINT *, xreal(i)
END DO

CALL hilbert(xreal,S,a_signal)

DO i=0,S-1
   PRINT*, a_signal(i), REAL(a_signal(i)), AIMAG(a_signal(i))
   WRITE(20,*) REAL(a_signal(i)), AIMAG(a_signal(i))
   
END DO

END PROGRAM 
