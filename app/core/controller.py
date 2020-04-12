class Controller:
    def __init__(self, model):
        self._model = model()
    def is_exist(self, key):
        return self._model.is_exist(key)