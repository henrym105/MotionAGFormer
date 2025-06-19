
# Download the entire AthletePose3D dataset
# This is 35 GB, so only do it in aws
# gdown https://drive.google.com/uc?id=1xnQDxvTjS9D9eYJMWsizbsfHSvxTnCxp


# Download the small 81 files from AthletePose3D dataset 
#  ----> (https://drive.google.com/drive/folders/10YnMJAluiscnLkrdiluIeehNetdry5Ft)
gdown https://drive.google.com/uc?id=1hlTR-5LVqxBFhMCs1yZilwbi255LB0MT
unzip pose_3d.zip -d ./data/
rm -rf pose_3d.zip


gdown --fuzzy --id 1xnQDxvTjS9D9eYJMWsizbsfHSvxTnCxp -O - | aws s3 cp - s3://shadow-trainer-dev/training/ap3d/data.zip
gdown --fuzzy --id 1hlTR-5LVqxBFhMCs1yZilwbi255LB0MT -O - | aws s3 cp - s3://shadow-trainer-dev/training/ap3d/pose_3d.zip

