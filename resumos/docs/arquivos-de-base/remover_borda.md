 # Remover borda preta de imagens
```python    
def remove_black_borders_auto(self, bgr):
    # Carregar imagem
    gray = cv2.cvtColor(bgr, cv2.COLOR_BGR2GRAY)
    
    # Aplicar threshold para encontrar as bordas pretas
    _, thresh = cv2.threshold(gray, 1, 255, cv2.THRESH_BINARY)
    
    # Encontrar contornos
    contours, _ = cv2.findContours(thresh, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)
    
    # Encontrar o contorno com maior área, supondo que seja a imagem sem as bordas pretas
    if contours:
        cnt = max(contours, key=cv2.contourArea)
        x, y, w, h = cv2.boundingRect(cnt)
        
        # Cortar a imagem para remover as bordas
        img_cropped = bgr[y:y+h, x:x+w]
        return img_cropped
    else:
        return bgr
```