import concurrent.futures as futures
import logging
import threading
import time

import numpy as np
import numpy.typing as npt
import pyautogui

import src.utils as utils
from src.accel_graph import SigmoidAccel

from src.singleton_meta import Singleton

logger = logging.getLogger("MouseController")

pyautogui.PAUSE = 0
pyautogui.FAILSAFE = False

# Max buffer number for apply smoothing.
N_BUFFER = 100


class MouseController(metaclass=Singleton):

    def __init__(self):
        logger.info("Intialize MouseController singleton")
        self.prev_x = 0
        self.prev_y = 0
        self.curr_track_loc = None
        self.smooth_kernel = None
        self.delay_count = 0
        self.top_count = 0
        self.is_started = False
        self.is_destroyed = False
        self.stop_flag = None
        self.is_active = None

    def start(self):
        if not self.is_started:
            logger.info("Start MouseController singleton")
            # Trackpoint buffer x, y
            self.buffer = np.zeros([N_BUFFER, 2])
            self.accel = SigmoidAccel()
            self.pool = futures.ThreadPoolExecutor(max_workers=1)
            self.screen_w, self.screen_h = pyautogui.size()
            self.calc_smooth_kernel()

            self.is_active = True#change with toggle
            #self.is_active.set(False)#auto_play

            self.stop_flag = threading.Event()
            self.pool.submit(self.main_loop)
            self.is_started = True

    def calc_smooth_kernel(self):
        new_pointer_smooth = 63 #pointer_smooth
        if self.smooth_kernel is None:
            self.smooth_kernel = utils.calc_smooth_kernel(new_pointer_smooth)

        elif new_pointer_smooth != len(self.smooth_kernel):
            self.smooth_kernel = utils.calc_smooth_kernel(new_pointer_smooth)

        else:
            pass

    def asymmetry_scale(self, vel_x, vel_y):
        if vel_x > 0:
            vel_x *= 40
        else:
            vel_x *= 40

        if vel_y > 0:
            vel_y *= 40
        else:
            vel_y *= 40

        return vel_x, vel_y

    def act(self, track_loc: npt.ArrayLike):
        self.curr_track_loc = track_loc

    def main_loop(self) -> None:
        """ Separate thread for mouse controller          
        """

        if self.is_destroyed:
            return

        while not self.stop_flag.is_set():
            if not self.is_active.get():
                time.sleep(0.001)
                continue

            self.buffer = np.roll(self.buffer, shift=-1, axis=0)
            self.buffer[-1] = self.curr_track_loc

            # Get latest x, y and smooth.
            smooth_px, smooth_py = utils.apply_smoothing(
                self.buffer, self.smooth_kernel)

            vel_x = smooth_px - self.prev_x
            vel_y = smooth_py - self.prev_y

            self.prev_x = smooth_px
            self.prev_y = smooth_py

            # In delay state
            self.delay_count += 1
            if self.delay_count < N_BUFFER:
                time.sleep(0.001)
                continue

            vel_x, vel_y = self.asymmetry_scale(vel_x, vel_y)

            if False:#mouse_acceleration
                vel_x *= self.accel(vel_x)
                vel_y *= self.accel(vel_y)

            # pydirectinput is not working here
            pyautogui.move(xOffset=vel_x, yOffset=vel_y)

            time.sleep(16 / 1000)#tick_interval_ms

    def set_active(self, flag: bool) -> None:
        self.is_active.set(flag)
        if flag:
            self.delay_count = 0

    def toggle_active(self):
        logging.info("Toggle active")
        curr_state = self.is_active.get()
        self.set_active(not curr_state)

    def destroy(self):
        if self.is_active is not None:
            self.is_active.set(False)
        if self.stop_flag is not None:
            self.stop_flag.set()
        self.is_destroyed = True
