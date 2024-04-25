import cv2

def draw_circle(image, postion, radius=3, color=(0, 255, 0), thickness=2):
    if postion:
        cv2.circle(image, (-int(postion[0]),int(postion[1])), radius, color, thickness)

def invert_frame(frame):
    return cv2.flip(frame, 1)
    