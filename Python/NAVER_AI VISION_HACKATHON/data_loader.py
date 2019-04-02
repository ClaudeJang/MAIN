# -*- coding: utf_8 -*-
from __future__ import absolute_import
from __future__ import division
from __future__ import print_function

import os
import cv2
import pickle



def train_data_loader(data_path, img_size, output_path):
    label_list = []
    img_list = []
    label_idx = 0

    for root, dirs, files in os.walk(data_path):
        if not files:
            continue
        for filename in files:
            img_path = os.path.join(root, filename)
            try:

                img = cv2.imread(img_path, 1) # 이미지 파일을 컬러로 읽음.
                img = img[250:750, 250:750] # cropping
                img = cv2.cvtColor(img, cv2.COLOR_BGR2RGB) # RGB으로 변환
                img = cv2.resize(img, img_size) # 리사이즈
                verti, hori, chan = img.shape

                img1 = cv2.flip(img, 1) # 좌우 반전
                img2 = cv2.flip(img, 0) # 상하 반전

                # cross = int(((hori * hori + verti * verti) ** 0.5))  # 정수여야 합니다.
                center = int(hori / 2), int(verti / 2)  # 역시 정수여야 합니다. 회전중심
                angleList = [35, 55, 60, 72, 81, 100, 130, 155, 195, 220, 275, 310, 325, 345]

                # 마음대로 정하세요
                newverti, newhori = verti, hori
                for i in range(len(angleList)):
                    pixelround = cv2.getRotationMatrix2D(center, angleList[i], 1)  # 1은 확대/축소값입니다.
                    result = cv2.warpAffine(img, pixelround, (newhori, newverti))
                    result2 = cv2.warpAffine(img1, pixelround, (newhori, newverti))
                    result3 = cv2.warpAffine(img2, pixelround, (newhori, newverti))
                    label_list.append(label_idx)
                    img_list.append(result)
                    img_list.append(result2)
                    img_list.append(result3)

                # # resize
                # if (img.shape[0] > img.shape[1]):
                #     tile_size = (int(img.shape[1] * 256 / img.shape[0]), 256)
                # else:
                #     tile_size = (256, int(img.shape[0] * 256 / img.shape[1]))
                # # centering
                # img = centering_image(cv2.resize(img, dsize=tile_size))
                # img_gen = ImageDataGenerator(
                #         rescale=1./255,
                #         rotation_range=40,
                #         width_shift_range = 0.2,
                #         height_shift_range = 0.2,
                #         shear_range =0.2,
                #         zoom_range = 0.2,
                #         horizontal_flip=True,)
                #
                # img = img_gen.flow_from_directory(
                #     img_path,
                #     img_size=img_size,
                #     batch_size=64,
                #     class_mode='categorical')
            except:
                continue
            label_list.append(label_idx)
            label_list.append(label_idx)
            img_list.append(img)
            img_list.append(img1)
            img_list.append(img2)
        label_idx += 1

    # write output file for caching
    with open(output_path[0], 'wb') as img_f:
        pickle.dump(img_list, img_f)
    with open(output_path[1], 'wb') as label_f:
        pickle.dump(label_list, label_f)


# nsml test_data_loader
def test_data_loader(data_path):
    data_path = os.path.join(data_path, 'test', 'test_data')
    # test_gen = ImageDataGenerator(rescale=1./255)
    #
    # validation_generator = test_gen.flow_from_directory(
    #     validation_dir,
    #     target_size=(150, 150),
    #     batch_size=32,
    #     class_mode='binary')
    # return full path
    queries_path = [os.path.join(data_path, 'query', path) for path in os.listdir(os.path.join(data_path, 'query'))]
    references_path = [os.path.join(data_path, 'reference', path) for path in
                       os.listdir(os.path.join(data_path, 'reference'))]

    return queries_path, references_path


if __name__ == '__main__':
    query, refer = test_data_loader('./')
    print(query)
    print(refer)
