PROGRAM HILBERT
IMPLICIT NONE

INTEGER :: i
INTEGER, PARAMETER :: S = 4096       !the nuber of sample point     

REAL*8, DIMENSION(0:S-1) :: f_real      !the real part of the FFT
REAL*8, DIMENSION(0:S-1) :: f_imag      !the imaginary part of the FFT
REAL*8, DIMENSION(0:S-1) :: f_magnitude


REAL*8, DIMENSION(0:S-1) :: h_real      !the real part of the Hibert transformed signal
REAL*8, DIMENSION(0:S-1) :: h_imag      !the real part of the Hibert transtormed signal
REAL*8, DIMENSION(0:S-1) :: h_magnitude


REAL*8, DIMENSION(0:S-1) :: phase      !the phase of the transformed signal
REAL*8, DIMENSION(0:S-1) :: phase_shift !Ideally, this filter has magnitude  1 at all frequencies and introduces a phase shift of $ -pi/2 at each positive frequency and $ +pi/2 at each negative frequency

REAL*8 :: pi=Acos(-1.0)


OPEN (10, FILE = "/home/changwan/HILBERT/FFT_GPR_output.txt", STATUS="OLD", FORM="FORMATTED", ACTION="READ")
OPEN (20, FILE =  "/home/changwan/HILBERT/HILBERT_ouput.txt",  STATUS="replace",  ACTION="WRITE")


!read the fourier-transformed data
DO i = 0, S-1  
   READ(10,*) f_real(i), f_imag(i), f_magnitude(i)
END DO



!calculated the phase from complex number
DO i =  0, S-1
    phase(i) = DATAN2(f_imag(i),f_real(i))
    phase(i) = phase (i) * 180.0 / pi
END DO



!Hibert filter
DO i = 0, S-1

   IF (i <=(S/2-1) ) THEN
       phase_shift(i) = phase(i) + 90.0 
   ELSE 
       phase_shift(i) = phase(i) - 90.0
   END IF

END DO



DO i = 0, S-1
    h_real(i) = f_magnitude(i) * DCOS(phase_shift(i))
    h_imag(i) = f_magnitude(i) * DSIN(phase_shift(i))
END DO


DO i = 0, S-1
   h_magnitude (i) = SQRT(h_real(i)**2 + h_imag(i)**2)
END DO

!write
DO i= 0, S-1
   WRITE(20,*) phase(i), phase_shift(i), h_real(i), h_imag(i), h_magnitude(i), f_magnitude(i)
END DO



END PROGRAM HILBERT
