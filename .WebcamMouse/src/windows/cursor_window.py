import tkinter as tk
from PIL import Image, ImageTk
import pyautogui
from src.singleton_meta import Singleton
from src.windows.custom_cursor import CustomCursor

class CursorWindow(metaclass=Singleton):

    def __init__(self):
        self.ancho_pantalla, self.alto_pantalla = pyautogui.size()
        self.root = tk.Tk()
        self.canvas = tk.Canvas(self.root, width=self.ancho_pantalla, height=self.alto_pantalla)
        self.canvas.pack(fill=tk.BOTH, expand=True)
        self.current_image = None  # Variable para almacenar la imagen actual
        self.canvas_image = None   # Variable para almacenar la referencia de la imagen en el canvas
        self.update_cursor_image()  # Actualizar la imagen inicial

    def update_cursor_image(self):
        new_img_pil = CustomCursor().icon.get_image()
        self.root.attributes('-alpha', CustomCursor().opacity) 
        # Verificar si la imagen ha cambiado
        if new_img_pil != self.current_image:
            self.current_image = new_img_pil
            self.img_tk = ImageTk.PhotoImage(self.current_image)
            
            # Si es la primera vez, crear la imagen en el canvas
            if self.canvas_image is None:
                self.canvas_image = self.canvas.create_image(200, 100, image=self.img_tk)
            else:
                # Actualizar la imagen en el canvas
                self.canvas.itemconfig(self.canvas_image, image=self.img_tk)

        # Programar la siguiente actualización
        self.root.after(100, self.update_cursor_image)

    def update_mouse_position(self):
        x, y = pyautogui.position()
        image_size = CustomCursor().icon.get_size()

        if CustomCursor().offset == "top_left":
            pointxy = (x + image_size[0]/2+5, y + image_size[1]/2+5)
        else:
            pointxy = (x, y)

        # Actualizar la posición del cursor en el canvas
        if self.canvas_image is not None:
            self.canvas.coords(self.canvas_image, *pointxy)

        # Programar la siguiente actualización
        self.root.after(10, self.update_mouse_position)

    def start(self):
        self.root.attributes('-alpha', CustomCursor().opacity) 
        self.root.attributes("-topmost", True)  
        self.root.attributes("-transparentcolor", self.root['bg'])
        #self.root.config(cursor="heart")

        # Establecer el tamaño de la ventana
        self.root.geometry(f"{self.ancho_pantalla}x{self.alto_pantalla}")
        self.update_mouse_position()
        self.root.overrideredirect(True)
        self.root.mainloop()

    def destroy(self):
        self.root.quit()
        self.root.destroy()

