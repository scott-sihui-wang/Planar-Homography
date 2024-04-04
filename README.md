# Planar Homography and Augmented Reality

## 1. Introduction

In this project, I first implemented `homography estimation` by feature point extraction, matching, and `RANSAC`. Then, I used the computation of `planar homography` to stitch two video scenarios together to generate an "augmented reality" scene.

For a more thourough introduction of my project, please refer to my [report](report.pdf).

**Topics:** _Computer Vision_, _Homography Estimation_, _Video Stitching_

**Skills:** _Matlab_

## 2. Demo

Extraction and matching of key points:

![RANSAC](/demo/RANSAC.png)

Input video 1:

![Input1](/demo/ar_source.gif)

Input video 2:

![Input2](/demo/book.gif)

Generated video:

![Output Video](/demo/ar.gif)
