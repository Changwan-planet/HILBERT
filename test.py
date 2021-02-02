import numpy as np
import matplotlib.pyplot as plt
import pandas as pd

path="/home/changwan/HILBERT/HILBERT_ouput.txt"

data=np.loadtxt(path)
data2=pd.DataFrame(data)

plt.subplot(611)
plt.plot(data2.loc[:,0],'b')

plt.subplot(612)
plt.plot(data2.loc[:,1], 'r')

plt.subplot(613)
plt.plot(data2.loc[:,2])

plt.subplot(614)
plt.plot(data2.loc[:,3])

plt.subplot(615)
plt.plot(data2.loc[:,4],'r')

plt.subplot(615)
plt.plot(data2.loc[:,5],'b')


plt.show()
