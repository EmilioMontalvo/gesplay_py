import tkinter as tk
from ctypes import windll
from PIL import Image, ImageTk
import pyautogui
from src.singleton_meta import Singleton

class CursorWindow(metaclass=Singleton):

    def __init__(self):
        self.ancho_pantalla,  self.alto_pantalla = pyautogui.size()
        self.root = tk.Tk()

    def start(self):
        def update_mouse_position():
            x, y = pyautogui.position()
            
            pointxy = (x+50, y+50)
            canvas.coords(cimg, pointxy)
            self.root.after(10, update_mouse_position)

        self.root.attributes("-topmost", True)  
        self.root.attributes("-transparentcolor", self.root['bg'])
        #root.config(cursor="none")
        
        # Obtener el tamaño de la pantalla con PyAutoGUI
        ancho_pantalla, alto_pantalla = pyautogui.size()

        # Establecer el tamaño de la ventana
        self.root.after(0, self.root.geometry, f"{self.ancho_pantalla}x{self.alto_pantalla}")
        self.root.geometry(f"{self.ancho_pantalla}x{self.alto_pantalla}")

        # Cargar la imagen sin aplicar transparencia
        img_pil = Image.open('cursor_1.png')
        img_tk = ImageTk.PhotoImage(img_pil)

        canvas = tk.Canvas(self.root)
        canvas.pack(expand=True, fill=tk.BOTH)  # Expandir el Canvas con la ventana

        cimg = canvas.create_image(200, 100, image=img_tk)

        # Iniciar la actualización continua de la posición del mouse
        update_mouse_position()
        self.root.update_idletasks()
        self.root.overrideredirect(True)
    
        # Obtener el handle de la ventana
        self.root.mainloop()
    
    def destroy(self):
        self.root.quit()  # Salir del bucle principal de tkinter
        self.root.destroy()

if __name__ == '__main__':
    CursorWindow().run()
