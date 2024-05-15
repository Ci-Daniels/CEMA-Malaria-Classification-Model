# CEMA-Malaria-Classification-Model
A machine learning model used to classify malaria blood smear into either uninfected or parasitized. The model uses datasets from Tensorflow 'malaria' dataset as its test, train and validation sets. 

## Abstract
TensorFlow Datasets has many datasets that can be loaded and used to learn more about image classification and various computer vision machine learning pipelines. One of the datasets hosted here is the "Malaria Dataset".

The Malaria dataset contains a total of 27,558 cell images with equal instances of parasitized and uninfected cells from the thin blood smear slide images of segmented cells.

**Remark**

This dataset consists of two directories, one is the parasitized cell images and the other is the uninfected cell images. Each of these directories has several images and labels. The label denotes the class to which that image belongs.

### To Do
- Create a model to classify the different blood smears into either parasitized or uninfected
- Transform the best model into a tfile model
- Use the model to correctly classify the different images selected from the image list

#### About
This repository hosts the Jupyter Notebook file that contains the trained model. The notebook contains two model versions both CNN models with different layers and complexities. I used the ensemble approach my decision being informed by the "Wisdom of Masses" analogy. In an ensembled model, two or more models are employed to increase the accuracy and generalization aspect of the model leveraging the strengths of the different models.

The following steps will allow you to clone the CEMA repository and run the file.
1. Copy the link below: [CEMA-MALARIA-REPOSITORY]()
2. Create an empty folder.
3. Navigate to your terminal preferably GIT BASH within that folder then type in **git clone** and paste [CEMA-MALARIA-REPOSITORY]()
4. This will allow you to clone the repository on your local drive.
5. From here run the notebook in your favourite environment.
6. You can load the trained model using: tf.keras.models.load_model('malaria_classification_model.h5') , In this case malaria_classification_model.h5 is the already trained model
