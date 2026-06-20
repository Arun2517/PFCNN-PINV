# PFCNN-PINV: Pre-defined Filter Convolutional Neural Network with Closed-Form Pseudo-Inverse Classifier (MATLAB)

> A MATLAB implementation of **Pre-defined Filter Convolutional Neural Networks (PFCNNs)** with a **Closed-Form Pseudo-Inverse (PINV)** classifier replacing the conventional fully connected output layer.

---

## Overview

Convolutional Neural Networks (CNNs) traditionally learn millions of trainable convolutional parameters through backpropagation. Recently, **Pre-defined Filter Convolutional Neural Networks (PFCNNs)** demonstrated that competitive image classification performance can be achieved using **fixed predefined convolution kernels**, while learning only the channel-wise combinations.

This repository extends the PFCNN concept by replacing the conventional fully connected classification layer with a **Closed-Form Pseudo-Inverse (PINV) classifier**. Instead of learning the final classifier using gradient descent, the output weights are computed analytically using the Moore-Penrose Pseudo-Inverse, resulting in a fast and deterministic classifier.

The implementation is developed entirely in **MATLAB**.

---

## Proposed Architecture

```text
                 Input Images
                       │
                       ▼
         Pre-defined Filter Module (PFM)
                       │
                       ▼
             Residual PFM Blocks
                       │
                       ▼
          Global Average Pooling (GAP)
                       │
                       ▼
              Feature Matrix (H)
                       │
                       ▼
         Closed-Form PINV Classifier
         W = pinv(H) × T
                       │
                       ▼
               Predicted Classes
```

---

## Motivation

Traditional CNN classifiers require iterative optimization using backpropagation.

This work investigates whether:

* Fixed convolution kernels can effectively extract image features.
* A closed-form analytical solution can replace the trainable fully connected classifier.
* Feature extraction and classification can be separated into two independent stages.

---

## Key Features

* MATLAB implementation of PFCNN.
* Fixed 3×3 predefined convolution filters.
* Pre-defined Filter Modules (PFMs).
* Residual network architecture.
* Global Average Pooling.
* Closed-form Pseudo-Inverse classifier.
* Modular MATLAB implementation.
* Easily extendable to different image datasets.

---

## Network Pipeline

```text
Input Images
      │
      ▼
Image Preprocessing
      │
      ▼
Pre-defined Filters
      │
      ▼
Depthwise Convolution
      │
      ▼
Pointwise (1×1) Convolution
      │
      ▼
Residual Blocks
      │
      ▼
Global Average Pooling
      │
      ▼
Feature Matrix H
      │
      ▼
Pseudo-Inverse Learning
      │
      ▼
Prediction
```

---

## Mathematical Formulation

### Feature Extraction

The convolutional backbone extracts a feature matrix

[
H = f(X)
]

where

* (X) — Input images
* (H) — Deep feature representation

---

### Closed-Form Output Weights

The classifier weights are obtained analytically as

[
W = \operatorname{pinv}(H)T
]

where

* (H) — Feature matrix
* (T) — One-hot encoded target matrix

---

### Prediction

Predicted outputs are computed as

[
Y = HW
]

The predicted class is

[
\hat{y} = \arg\max(Y)
]

---

## Repository Structure

```text
PFCNN-PINV/
│
├── README.md
├── LICENSE

---

## Training Procedure

1. Load image dataset.
2. Preprocess images.
3. Extract deep features using the PFCNN backbone.
4. Apply Global Average Pooling.
5. Construct the feature matrix.
6. Compute output weights using the Moore-Penrose Pseudo-Inverse.
7. Perform prediction on testing images.
8. Evaluate classification performance.

---

## Advantages

* Reduced trainable parameters.
* Closed-form output layer.
* No iterative optimization for the classifier.
* Faster training.
* Deterministic solution.
* Modular architecture.
* Easy to reproduce.

---

## Example

```matlab
% Feature extraction
Htrain = extractFeatures(trainImages);

% One-hot targets
Ttrain = oneHotEncoding(trainLabels);

% Closed-form learning
W = pinv(Htrain) * Ttrain;

% Testing
Htest = extractFeatures(testImages);
Y = Htest * W;

[~,predictedLabels] = max(Y,[],2);
```

---

## Results

The following metrics will be reported after implementation:

| Dataset        | Training Accuracy | Testing Accuracy |
| -------------- | ----------------: | ---------------: |
| CIFAR-10       |                -- |               -- |
| Caltech101     |                -- |               -- |
| Flowers102     |                -- |               -- |
| Custom Dataset |                -- |               -- |

---

## Future Work

* Support additional datasets.
* Explore different predefined filter banks.
* Integrate PINV into intermediate layers.
* Compare with Extreme Learning Machine (ELM) classifiers.
* Evaluate robustness against adversarial perturbations.
* Extend the framework to object detection and segmentation.

---

---

## Citation

If you use this repository in your research, please cite both the original PFCNN paper and this implementation.

---


## Author

**Arun G**


Research Interests:

* Closed-Form Neural Networks
* Pseudo-Inverse Learning
* Computer Vision
* Deep Learning
* Pattern Recognition

---

**If you find this repository useful, consider giving it a ⭐ on GitHub.**

