import logging
import sys

from src.pipeline import Pipeline
from src.task_manager import TaskManager
import concurrent.futures as futures

FORMAT = "%(asctime)s %(levelname)s %(name)s: %(funcName)s: %(message)s"
logging.basicConfig(format=FORMAT,
                    level=logging.INFO,
                    handlers=[
                        logging.FileHandler("log.txt", mode='w'),
                        logging.StreamHandler(sys.stdout)
                    ])

def main_loop():
    pipeline = Pipeline()
    while TaskManager().is_running:
        pipeline.pipeline_tick()

if __name__ == "__main__":
    
    logging.info("Starting main app")
    TaskManager().start()
    pool = futures.ThreadPoolExecutor(max_workers=1)
    TaskManager().pipeline_thread = pool
    pool.submit(main_loop)
    
    from src.windows.cursor_window import CursorWindow
    CursorWindow().start()
