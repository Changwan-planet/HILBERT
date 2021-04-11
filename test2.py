import numpy as np
import matplotlib.pyplot as plt
import pandas as pd

path="/home/changwan/HILBERT/HILBERT_output.txt"
#path="/home/changwan/HILBERT/IFFT_output.txt"
#path2="/home/changwan/GPR/A_SCOPE_GPR.txt"
#path3="/home/changwan/GPR/A_SCOPE_GPR2.txt"
#path4="/home/changwan/FFT/FFT_GPR_output.txt"
#path5="/home/changwan/HILBERT/HILBERT_output.txt"
#path6="/home/changwan/HILBERT/IFFT_output.txt"




data = np.loadtxt(path)
data_2 = pd.DataFrame(data)

#data2 = np.loadtxt(path2)
#data2_2 = pd.DataFrame(data2)

#data3 = np.loadtxt(path3)
#data3_2 = pd.DataFrame(data3)

#data4 = np.loadtxt(path4)
#data4_2 = pd.DataFrame(data4)

#data5 = np.loadtxt(path5)
#data5_2 = pd.DataFrame(data5)

#data6 = np.loadtxt(path6)
#data6_2 = pd.DataFrame(data6)


#
plt.subplot(311)
plt.plot(data_2.loc[:,0], 'r')
plt.grid()

plt.subplot(312)
plt.plot(data_2.loc[:,1],'b')
plt.grid()

#plt.subplot(614)
#plt.plot(data4_2.loc[:,3], 'r')
#plt.grid()

#plt.subplot(313)
#plt.plot(data_2.loc[:,2],'b')
#plt.grid()

#plt.subplot(616)
#plt.plot(data6_2.loc[:,5], 'r')
#plt.grid()



#plt.subplot(313)
#plt.plot(data2.loc[:,1], 'g')


plt.show()
