#!/bin/bash

# Download pretrained model weights 
rm -rf ./demo/lib/checkpoint
mkdir ./demo/lib/checkpoint

gdown https://drive.google.com/uc?id=1YgA9riqm0xG2j72qhONi5oyiAxc98Y1N
mv 'yolov3.weights' './demo/lib/checkpoint/'

gdown https://drive.google.com/uc?id=1YLShFgDJt2Cs9goDw9BmR-UzFVgX3lc8
mv 'pose_hrnet_w48_384x288.pth' './demo/lib/checkpoint/'

# # moganet, best performing 2d keypoint detector on athlete3D
# gdown https://drive.google.com/uc?id=1gTTGO7AQhNUWX1Fh3K1CYLQ3zYeB8CX3
# mv 'moganet_b_ap2d_384x288.pth' './demo/lib/checkpoint/'


# -------------------------------------------------------
# Model weights trained on h36m dataset:
# -------------------------------------------------------
gdown https://drive.google.com/uc?id=1Iii5EwsFFm9_9lKBUPfN8bV5LmfkNUMP
mv 'motionagformer-b-h36m.pth.tr' './demo/lib/checkpoint/motionagformer-b-h36m.pth.tr'

gdown https://drive.google.com/uc?id=1Pab7cPvnWG8NOVd0nnL1iqAfYCUY4hDH
mv 'motionagformer-xs-h36m.pth.tr' './demo/lib/checkpoint/motionagformer-xs-h36m.pth.tr'

gdown https://drive.google.com/uc?id=1WI8QSsD84wlXIdK1dLp6hPZq4FPozmVZ
mv 'motionagformer-l-h36m.pth.tr' './demo/lib/checkpoint/motionagformer-l-h36m.pth.tr'

# -------------------------------------------------------
# Model weights trained on h36m + AthletePose3 dataset:
# -------------------------------------------------------
gdown https://drive.google.com/uc?id=1lirw_u3o5nT6nsTQVHO5XS9gUpi4SDEe
mv 'motionagformer-s-ap3d.pth.tr' './demo/lib/checkpoint/motionagformer-s-ap3d.pth.tr'
