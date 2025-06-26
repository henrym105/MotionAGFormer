import sys
import os
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), 'demo')))

import streamlit as st
import os
import sys
import tempfile
import numpy as np
import matplotlib.pyplot as plt
from demo.vis import get_pose2D, get_pose3D, img2video, get_pytorch_device

st.set_page_config(page_title="MotionAGFormer Demo Dashboard", layout="wide")
st.title("MotionAGFormer Streamlit Dashboard")

st.markdown("""
This dashboard lets you run the MotionAGFormer demo pipeline on a video and visualize the 2D and 3D pose results.
""")

# Video upload or selection
st.header("1. Select or Upload a Video")
video_file = st.file_uploader("Upload a video file (mp4, mov)", type=["mp4", "mov"])

video_path = None
output_dir = None
video_name = None

if video_file is not None:
    tfile = tempfile.NamedTemporaryFile(delete=False, suffix='.mp4')
    print(f"Temporary file created at: {tfile.name}")
    tfile.write(video_file.read())
    print(f"Video file written to temporary file: {tfile.name}")
    video_path = tfile.name
    print(f"video_path set to: {video_path}")
    video_name = os.path.splitext(os.path.basename(video_path))[0]
    print(f"video_name set to: {video_name}")
    output_dir = os.path.join("demo/output", video_name)
    print(f"output_dir set to: {output_dir}")
    os.makedirs(output_dir, exist_ok=True)
    print(f"Output directory created (if not exists): {output_dir}")
else:
    print("No video file uploaded.")
    # Optionally, let user pick from sample videos
    sample_videos = [f for f in os.listdir("demo/video") if f.endswith((".mp4", ".mov"))]
    if sample_videos:
        video_choice = st.selectbox("Or select a sample video", sample_videos)
        if video_choice:
            video_path = os.path.join("demo/video", video_choice)
            video_name = os.path.splitext(video_choice)[0]
            output_dir = os.path.join("demo/output", video_name)
            os.makedirs(output_dir, exist_ok=True)

if video_path:
    st.video(video_path)
    st.write(f"**Selected video:** {video_path}")

    # Device selection
    st.header("2. Select Device")
    device = get_pytorch_device()
    st.write(f"Using device: {device}")

    # Model size selection
    st.header("3. Select Model Size")
    model_size = st.selectbox("Model size", ["xs", "s", "b", "l"], index=2)
    model_config_map = {
        "xs": "./configs/h36m/MotionAGFormer-xsmall.yaml",
        "s": "./configs/h36m/MotionAGFormer-small.yaml",
        "b": "./configs/h36m/MotionAGFormer-base.yaml",
        "l": "./configs/h36m/MotionAGFormer-large.yaml",
    }
    model_config = model_config_map[model_size]

    if st.button("Run Pose Estimation"):
        with st.spinner("Running 2D pose estimation..."):
            get_pose2D(video_path, output_dir, device)
        st.success("2D pose estimation complete.")
        with st.spinner("Running 3D pose estimation..."):
            get_pose3D(video_path, output_dir, device, model_size, model_config)
        st.success("3D pose estimation complete.")
        with st.spinner("Generating output video..."):
            img2video(video_path, output_dir)
        st.success("Output video generated.")

    # Show outputs if available
    st.header("4. Results")
    keypoints_npz = os.path.join(output_dir, "input_2D", "keypoints.npz")
    output_video = os.path.join(output_dir, video_name + ".mp4")
    if os.path.exists(keypoints_npz):
        st.subheader("2D Keypoints (first frame)")
        data = np.load(keypoints_npz)
        kpts = data["reconstruction"]
        if kpts.ndim == 3:
            img = np.zeros((int(720), int(1280), 3), dtype=np.uint8)
            from demo.vis import show2Dpose
            img = show2Dpose(kpts[0], img)
            st.image(img, caption="2D Keypoints Overlay", channels="BGR")
    if os.path.exists(output_video):
        st.subheader("Output Video with 2D/3D Poses")
        st.video(output_video)
else:
    st.info("Please upload or select a video to begin.")
