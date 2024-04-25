import logging
import pyautogui
import numpy as np
import numpy.typing as npt
import src.utils as utils
import time
import concurrent.futures as futures
from src.singleton_meta import Singleton

# Max buffer number for apply smoothing.
N_BUFFER = 100
pyautogui.PAUSE = 0
pyautogui.FAILSAFE = False

class MouseController(metaclass=Singleton):
    def __init__(self) -> None:
        self.prev_x = 0
        self.prev_y = 0
        self.is_started=False
        self.is_stoped=True
        self.is_destroyed=False
        self.smooth_kernel=None
        self.curr_track_loc=None
        self.buffer =None
        self.is_active=False

    def start(self):
        if not self.is_started:
            logging.info("MouseController started")
            self.is_started=True
            self.is_stoped=False
            self.buffer = np.zeros([N_BUFFER, 2])
            self.calc_smooth_kernel()
            #create a new thread
            self.pool = futures.ThreadPoolExecutor(max_workers=1)
            self.pool.submit(self.main_loop)
            

    
    def stop(self):
        self.is_stoped=True
    
    def resume(self):
        self.is_stoped=False
    
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
    
    def calc_smooth_kernel(self):
        new_pointer_smooth = 63
        if self.smooth_kernel is None:
            self.smooth_kernel = utils.calc_smooth_kernel(new_pointer_smooth)

        elif new_pointer_smooth != len(self.smooth_kernel):
            self.smooth_kernel = utils.calc_smooth_kernel(new_pointer_smooth)

        else:
            pass


    def main_loop(self):
        if self.is_destroyed:
            return
        logging.info("MouseController thread started")
        while not self.is_stoped:
            if not self.is_active:
                time.sleep(0.001)
                continue
            if self.curr_track_loc:
                self.buffer = np.roll(self.buffer, shift=-1, axis=0)
                self.buffer[-1] = self.curr_track_loc

                smooth_px, smooth_py = utils.apply_smoothing(
                    self.buffer, self.smooth_kernel)
                
                vel_x = smooth_px - self.prev_x
                vel_y = smooth_py - self.prev_y

                vel_x, vel_y = self.asymmetry_scale(vel_x, vel_y)


                self.prev_x = smooth_px
                self.prev_y = smooth_py
                
                pyautogui.move(xOffset=vel_x, yOffset=vel_y)
                time.sleep(16 / 1000)
            
    def act(self, track_loc: npt.ArrayLike):
        
        if(track_loc):
            if not self.is_active:
                self.is_active=True
            self.curr_track_loc = track_loc
            print(track_loc)
        else:
            self.is_active=False
        
    
    def destroy(self):
        self.is_active=False
        self.is_started=False
        self.is_stoped=True
        self.is_destroyed=True

