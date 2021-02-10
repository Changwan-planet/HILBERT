import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
import math 

path="/home/changwan/HILBERT/HILBERT_output.txt"

data=np.loadtxt(path)
data2=pd.DataFrame(data)


"""
plt.subplot(311)
plt.plot(data2.loc[:,0],'b')
plt.plot(data2.loc[:,2],'g')
plt.grid()

plt.subplot(312)
plt.plot(data2.loc[:,1], 'b')
plt.plot(data2.loc[:,3], 'g')
plt.grid()


plt.subplot(313)
plt.plot(data2.loc[:,4], 'b')
plt.plot(data2.loc[:,5], 'g')
plt.grid()
"""

plt.subplot(311)
#plt.plot(data2.loc[:,0])
plt.plot(data2.loc[:,0])
plt.plot(data2.loc[:,3])


plt.subplot(312)
plt.plot(data2.loc[:,1])

plt.subplot(313)
x = 10*math.log10(data2.loc[:,2])

plt.plot(x)

#plt.plot(data2.loc[:,2][450:1000])


plt.grid()

plt.show()
