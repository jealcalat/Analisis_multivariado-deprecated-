import glob
import subprocess


home = '/home/mrrobot/Documents/GitHub/Analisis_multivariado/'
jupyter_list = glob.glob(home + '/*/*.ipynb')
for item in jupyter_list:
    command = 'quarto render ' + item
    subprocess.call(command, shell=True)
    print(item)

# print(jupyter_list)
