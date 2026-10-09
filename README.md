# Computer Vision Experiments

MATLAB exercises exploring camera calibration, planar homography, 3D projection, and point tracking on images and video.

```text
Calibration images -> camera parameters -> homography / projection
                                      -> image or video overlays
```

## Contents

- `cameraCalibrator.m` estimates camera parameters from checkerboard images in `image jpg/`.
- `calculating_h.m` computes a planar homography from paired image and world points.
- `projecting_cube_on_image.m` and `affiche_sur_image.m` draw geometric results on `A.jpeg`.
- `image_video.m` tracks points and draws a cube on `C.mp4`.
- `camera_par.m` is an additional calibration experiment using DNG images.

## Using the scripts

Open the repository in MATLAB with the required computer vision functionality available. Start with `cameraCalibrator.m` to inspect the calibration images and estimated parameters. The image paths in the calibration scripts are relative to this repository.

These are separate experiments, not a single automated application. Some scripts expect matrices such as `H` or `P` to already exist in the MATLAB workspace, and the video script asks you to select points interactively. The DNG files referenced by `camera_par.m` are not included; place your own compatible images in an `Expert RAW/` folder if you want to run that experiment.

## Status

This repository records learning experiments. The scripts have not been packaged or verified as an end-to-end workflow.
