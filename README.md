# CSE_572_DataMining

In this project, we are attempting to develop a computing system that can understand human gestures. 

### Data Collection

Large data of 10 actions with each 20 repetitions of 47 teams is collected using four sensors accelerometer, gyroscope, orientation and EMG which produced 18 data streams for each repetition. 

### Data Cleaning

Data has been cleaned by removing the noisy data which is caused by unintended and unwanted actions and also the actions caused by incorrectly wearing the sensors.


### Data Transformation

An intuition is made for selecting the features to be implemented on the sensor values by looking at the patterns among the gestures. In MATLAB raw data is transformed using feature extraction methods, normalized and Principle component analysis is implemented for dimensionality reduction, to see distinction among the actions. 


### Implementing Algorithms

The top 4 features of the PCA are chosen and machine learning algorithms of Support vector machines, Decision trees and Neural networks are implemented. 60% of the available data has been used as training and remaining 40% as testing for the algorithms.
For each action the best machine is evaluated among other two for differentiating that action from others. For each action an average accuracy of 80% has been achieved.
