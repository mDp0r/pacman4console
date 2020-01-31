import numpy as np
import pandas as pd
import os
#Session filename to evaluate
filename="sessions_5.dat"
raw_data=np.loadtxt(filename,int)
f=pd.DataFrame(columns=["State", "Action", "Score", "Session"], data=raw_data)
f["Score_t+1"]=f.groupby(["Session"])["Score"].shift(-1)
f["Score_t+2"]=f.groupby(["Session"])["Score"].shift(-2)
f["Score_t+3"]=f.groupby(["Session"])["Score"].shift(-3)
f["Score_t+4"]=f.groupby(["Session"])["Score"].shift(-3)
f["Score_t+5"]=f.groupby(["Session"])["Score"].shift(-5)
f["R_t1"]=f["Score_t+1"]-f["Score"]
f["R_t2"]=f["Score_t+2"]-f["Score_t+1"]
f["R_t3"]=f["Score_t+3"]-f["Score_t+2"]
f["R_t4"]=f["Score_t+4"]-f["Score_t+3"]
f["R_t5"]=f["Score_t+5"]-f["Score_t+4"]
f.fillna(0, inplace=True)
#Reward weights
x1=0.3
x2=0.25
x3=0.2
x4=0.15
x5=0.1
f["R"]=x1*f["R_t1"]+x2*f["R_t2"]+x3*f["R_t3"]+x4*f["R_t4"]+x4*f["R_t4"]
f=f.groupby(["State","Action"])["R"].mean().astype(int).unstack(fill_value=0).reset_index()
del f.columns.name
f.set_index("State", inplace=True)
del f.index.name
Q=os.listdir("Q/")
for index, row in f.iterrows():
    filename=str(index)+".dat"
    if filename in Q:
        file_old=np.loadtxt("Q/"+filename)
        ((file_old+row.values)/2).astype(int).tofile("Q/"+filename, sep=" ", format="%d")
    else:
        row.values.tofile("Q/"+filename,sep=" ", format="%d")