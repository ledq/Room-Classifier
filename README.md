# Room-Classifier

Classifier for 5 room types: bedroom, bathroom, dining room, living room, kitchen) from images despite wide variability
in room appearances

Used CNN transfer learning with pre-trained AlexNet to train the dataset of 3030 images per class and achieved an
accuracy of around 0.95

Implementing YOLOv5 for furniture detection (In progress)

YOLOv5 training options:
python train.py --img 640 --batch 12 --epochs 30 --data dataset/fu
rniture.v2-release.yolov5pytorch/data.yaml --weights yolov5m.pt --cache ram

