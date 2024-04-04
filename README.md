# Planar Homography and Augmented Reality

## 1. Introduction

In this project, I first implemented `homography estimation` by feature point extraction, matching, and `RANSAC`. Then, I used the computation of `planar homography` to stitch two video scenarios together to generate an "augmented reality" scene.

**Topics:** _Computer Vision_, _Homography Estimation_, _Video Stitching_

**Skills:** _Matlab_

## 2. Demo

Extraction and matching of key points:

![RANSAC](/demo/RANSAC.png)

Input video 1:

<video src="/data/book.mp4" width="320" height="240" controls></video>

<video width="320" height="240" controls>
  <source src="data/book.mp4" type="video/mp4">
</video>


![RANSAC](data/book.mp4)
Input video 2:

![Input Video 2](/demo/input2.gif)

Generated video:

![Output Video](/demo/output.gif)
