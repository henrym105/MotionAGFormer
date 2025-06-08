conda create -n MAG python=3.8.10 -y 
conda activate MAG

conda install pytorch==2.0.0 torchvision==0.15.0 -c pytorch -c nvidia -y
pip install -r requirements-osx.txt



# conda init
# conda env remove -n MAG
# conda create --name MAG --file requirements-osx.txt
# conda activate MAG