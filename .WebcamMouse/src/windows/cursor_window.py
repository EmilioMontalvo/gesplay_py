import tkinter as tk
from ctypes import windll
from PIL import Image, ImageTk
import pyautogui
from src.singleton_meta import Singleton

class CursorWindow(metaclass=Singleton):

    def __init__(self):
        self.ancho_pantalla,  self.alto_pantalla = pyautogui.size()

    def run(self):
        

        def update_mouse_position():
            x, y = pyautogui.position()
            
            pointxy = (x+50, y+50)
            canvas.coords(cimg, pointxy)
            root.after(10, update_mouse_position)

        root = tk.Tk()
        root.attributes("-topmost", True)  
        root.attributes("-transparentcolor", root['bg'])
        #root.config(cursor="none")
        
        # Obtener el tamaño de la pantalla con PyAutoGUI
        ancho_pantalla, alto_pantalla = pyautogui.size()

        # Establecer el tamaño de la ventana
        root.after(0, root.geometry, f"{self.ancho_pantalla}x{self.alto_pantalla}")
        root.geometry(f"{self.ancho_pantalla}x{self.alto_pantalla}")

        # Cargar la imagen sin aplicar transparencia
        img_pil = Image.open('cursor_1.png')
        img_tk = ImageTk.PhotoImage(img_pil)

        canvas = tk.Canvas(root)
        canvas.pack(expand=True, fill=tk.BOTH)  # Expandir el Canvas con la ventana

        cimg = canvas.create_image(200, 100, image=img_tk)

        # Iniciar la actualización continua de la posición del mouse
        update_mouse_position()
        root.update_idletasks()
        root.overrideredirect(True)
    
        # Obtener el handle de la ventana
        root.mainloop()

if __name__ == '__main__':
    CursorWindow().run()
