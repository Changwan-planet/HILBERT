!> \file HILBERT.f90 

PROGRAM HILBERT

USE module_signal

IMPLICIT NONE

INTEGER :: i
INTEGER, PARAMETER :: S = 4096       !the number of sample point     
REAL*8, PARAMETER ::  pi = ACOS(-1.0)


REAL*8, DIMENSION(0:S-1) :: xreal           !the real part of RAW gpr data
REAL*8, DIMENSION(0:S-1) :: ximag           !the imaginary part of RAW gpr data


REAL*8, DIMENSION(0:S-1) :: fft_real        !the real part of FFT
REAL*8, DIMENSION(0:S-1) :: fft_imag        !the imaginary part FFT


REAL*8, DIMENSION(0:S-1) :: ifft_real       !the real part of IFFT
REAL*8, DIMENSION(0:S-1) :: ifft_imag       !the imaginary part IFFT


COMPLEX*8, DIMENSION(0:S-1) :: y_imag       !the phase-shifted signal
COMPLEX*8, DIMENSION(0:S-1) :: a_signal     !the analytical signal


REAL*8, DIMENSION(0:S-1) :: a_real          !the real part of the analytical signal
REAL*8, DIMENSION(0:S-1) :: a_imag          !the imaginary part of the analytical signal

REAL*8, DIMENSION(0:S-1) :: h_real          !the real part of the Hibert transformed signal
REAL*8, DIMENSION(0:S-1) :: h_imag          !the imag part of the Hibert transtormed signal


REAL*8, DIMENSION(0:S-1) :: a_magnitude
REAL*8, DIMENSION(0:S-1) :: a_ifft_real     !the real part of the IFFT, Hibert transformed signal
REAL*8, DIMENSION(0:S-1) :: a_ifft_imag     !the imag part of the IFFT, Hibert transtormed signal


REAL*8, DIMENSION(0:S-1) :: phase      !the phase of the transformed signal
REAL*8, DIMENSION(0:S-1) :: phase_shift !Ideally, this filter has magnitude  1 at all frequencies and introduces a phase shift of $ -pi/2 at each positive frequency and $ +pi/2 at each negative frequency


OPEN (10, FILE = "/home/changwan/GPR/A_SCOPE_GPR.txt", STATUS="OLD", FORM="FORMATTED", ACTION="READ")
OPEN (20, FILE =  "/home/changwan/HILBERT/HILBERT_output.txt",  STATUS="REPLACE",  ACTION="WRITE")


!read the RAW gpr data
 

a_signal = 0

READ(10,*) xreal

ximag = 0.0

xreal=xreal-SUM(xreal)/SIZE(xreal)
PRINT*, SUM(xreal)/SIZE(xreal)


!DO i=0, S-1
!   PRINT *, xreal(i)
!END DO

!fourier transform
CALL fft(xreal, ximag, S, fft_real, fft_imag)


!shifted the phased by pi/2
!filtered out the negative-frequency components of a siganl

!DO i = 0, S-1
!   IF (i <=(S/2-1) ) THEN
!       y_imag(i) = cmplx(fft_real(i), fft_imag(i)) * cmplx (cos(-pi/2), sin(-pi/2))
!   ELSE  
!       y_imag(i) = cmplx(fft_real(i), fft_imag(i)) * cmplx (cos(pi/2), sin(pi/2))
!   END IF
!END DO


!h_signal = cmplx(fft_real, fft_imag) * cmplx (cos(pi/2), sin(pi/2))



!extractn the real and imaginary components from the complex number
!DO i = 0, S-1
!   a_signal(i) = fft_real(i) + y_imag(i)
!END DO

!a_real = REAL(a_signal)
!a_imag = AIMAG(a_signal)

!write
!DO i=0, S-1
!   PRINT *,   a_real(i), a_imag(i), xreal(i)
!   WRITE(20,*) a_real(i), a_imag(i), xreal(i)
!END DO
 

!h_real = REAL(h_signal)
!h_imag = AIMAG(h_signal)



!calculated the phase from the real and imaginary parts
!DO i=0, S-1
!   phase(i)  = DATAN2(fft_imag(i) , fft_real(i))
!   phase_shift(i)= DATAN2(h_imag(i), h_real(i)) 
!END DO



!transformed radian into degree
!DO i=0,S-1
!   phase(i) = phase(i) * (180.0/pi)
!   phase_shift(i) =phase_shift(i) * (180.0/pi)
!END DO


!write
!DO i=0, S-1
!   PRINT *,   fft_real(i), fft_imag(i), h_real(i), h_imag(i), phase(i), phase_shift(i)
!   WRITE(20,*)fft_real(i), fft_imag(i), h_real(i), h_imag(i), phase(i), phase_shift(i)
!END DO
 

!filtered out the negative-frequency components of a siganl
DO i = 0, S-1
   IF (i <=(S/2-1) ) THEN
       a_real(i) = 0 
       a_imag(i) = 0 
   ELSE  
       a_real(i) = 2 * fft_real(i)
       a_imag(i) = 2 * fft_imag(i) 
   END IF
END DO

!DO i=0, S-1
!   PRINT *, a_real(i), a_imag(i)
!END DO


!DO i=0, S-1
!   PRINT *, h_signal(i), h_real(i), h_imag(i)
!END DO
 
!inverse fourier transform
CALL ifft(a_real, a_imag, S, a_ifft_real, a_ifft_imag)


DO i = 0, S-1
  a_magnitude (i) = SQRT(a_ifft_real(i)**2 + a_ifft_imag(i)**2)
END DO


!write
DO i= 0, S-1
    !WRITE(20,*) f_real(i), f_imag(i)
!    WRITE(20,*) phase(i), phase_shift(i), h_real(i), h_imag(i), h_magnitude(i), f_magnitude(i)
!    WRITE(20,*) h_real(i), h_imag(i), h_magnitude(i)
    
  PRINT*,a_ifft_real(i), a_ifft_imag(i), a_magnitude(i),xreal(i)
  WRITE(20,*) a_ifft_real(i), a_ifft_imag(i), a_magnitude(i), xreal(i)

END DO

END PROGRAM HILBERT
