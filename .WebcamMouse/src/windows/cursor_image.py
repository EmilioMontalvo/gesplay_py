from PIL import Image, ImageDraw, ImageEnhance
import os

class CursorImage:
    def __init__(self, file_name):
        base_dir = os.path.dirname(os.path.dirname(__file__))
        image_path = os.path.join(base_dir, f"images\cursors\{file_name}")
        self.image = Image.open(image_path).convert("RGBA")
        self.original_image = self.image.copy()  # Keep a copy of the original image

    def resize(self, width, height):
        self.image = self.original_image.resize((width, height), Image.Resampling.LANCZOS)
        return self.image
    
    def resize_with_aspect_ratio(self, new_size):
        # Calculate the new size while preserving aspect ratio
        if new_size <= 0:
            raise ValueError("New size must be greater than 0.")
        if new_size == 1:
            return self.image

        width, height = self.original_image.size
        aspect_ratio = width / height

        if width > height:
            new_width = new_size
            new_height = int(new_size / aspect_ratio)
        else:
            new_height = new_size
            new_width = int(new_size * aspect_ratio)

        self.image = self.original_image.resize((new_width, new_height), Image.Resampling.LANCZOS)
        return self.image


    def change_color(self, color):
        if color is None:
            return self.image
        # Separate the alpha channel
        r, g, b, a = self.image.split()
        # Create a color image and combine it with the alpha channel as a mask
        # Multiply each member of color by 255 and convert to int
        color = tuple(int(c * 255) for c in color)
        
        # Create a color image and combine it with the alpha channel as a mask
        color_image = Image.new("RGBA", self.image.size, color)
        self.image = Image.composite(color_image, self.image, a)
        color_image = Image.new("RGBA", self.image.size, color)
        self.image = Image.composite(color_image, self.image, a)
        return self.image

    def change_opacity(self, opacity):
        # Ensure opacity is between 0 and 1
        if not (0 <= opacity <= 1):
            raise ValueError("Opacity must be between 0 and 1.")
        alpha = self.image.split()[3]  # Get the alpha channel
        alpha = ImageEnhance.Brightness(alpha).enhance(opacity)
        self.image.putalpha(alpha)
        return self.image

    def get_image(self):
        return self.image
    
    def get_size(self):
        return self.image.size


