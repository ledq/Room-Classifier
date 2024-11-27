# Description
Classifier for 5 room types: bedroom, bathroom, dining room, living room, kitchen) from images despite wide variability
in room appearances.
Applications in real estate, interior design, robotics, and security for automating room identification and improving task efficiency.

# Example predictions:
![image](https://github.com/user-attachments/assets/43d38caa-6867-41bc-8e8b-5c5a9dcbcfa7)
![image](https://github.com/user-attachments/assets/1867acd8-41c8-43cc-b04d-2d234a12a8e2)
![image](https://github.com/user-attachments/assets/8d03966d-7c95-47d0-84af-bdcb5c6315e5)
![image](https://github.com/user-attachments/assets/5770aaa7-1bdc-456c-b7a5-9c1b157f5b3b)

# Accuracy analysis:
Used CNN transfer learning with pre-trained AlexNet to train the dataset of 3030 images per class and achieved an
accuracy of around 0.935
![image](https://github.com/user-attachments/assets/d5b94b4d-c5b9-4759-8fa9-984c09611de1)
![image](https://github.com/user-attachments/assets/5f1c35b1-7e52-4be2-8523-03ebabd275d4)

Implementing YOLOv5 for furniture detection (In progress)

![image](https://github.com/user-attachments/assets/986ccb89-f2e8-441a-a030-dd1c97a897b9)

YOLOv5 training options:
python train.py --img 640 --batch 12 --epochs 30 --data dataset/fu
rniture.v2-release.yolov5pytorch/data.yaml --weights yolov5m.pt --cache ram

