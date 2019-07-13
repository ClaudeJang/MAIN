#%%
pip install numpy


#%%
import numpy as np 
import matplotlib.pyplot as plt
%matplotlib inline

#%%
max_iter = 100
h, w = 400, 400

img = np.zeros((h,w)).astype('int')
for i, real in enumerate(np.linspace(-1.5, 0.5, w)):
    for j, real in enumerate(np.linspace(-1,1,h)):
        c = complex(real, imag)
        z = 0 + 0j
        for k in range(max_iter):
            z = z*z + c
            if abs(z) > 2:
                break
        img[j, i] = k

plt.grid(False)
plt.imshow(img, cmap=plt.cm.jet)