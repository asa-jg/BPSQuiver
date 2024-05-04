# BPSQuiver
MATLAB Code for analysis of BPS Quivers and their Schur Indices. Mathematica support in progress.

## MATLAB Code

## Installation Instructions

### Prerequisites

Before installing this MATLAB code, ensure you have MATLAB installed on your system. This code is compatible with MATLAB R2021a and potentially with older versions.

### Clone the Repository

To download the project, clone the repository using the following command on the terminal:

  ```
  git clone https://github.com/asa-jg/BPSQuiver.git
  ```

### Setup in MATLAB

After cloning the repository, you need to set it up in MATLAB:

1. **Open MATLAB** and navigate to the directory where you cloned the repository.

2. **Add the Repository to MATLAB's Path**:
   To ensure that MATLAB can access the scripts from any location within its environment, add the repository to MATLAB's path using the following command in the MATLAB Command Window:

  ```matlab
  addpath(genpath('path_to_cloned_repository'))
  ```
## Usage

Total support is currently available for BPS Quivers containing no flavour symmetry.

In main.m, run `NFS(M,Range,Rank)` where `M` is the adjacency matrix, `Range` is the desired maximum exponent of `q` in the Schur Index, and `Rank` is the rank of the Coulomb Branch.

## Mathematica Code
Coming soon.
