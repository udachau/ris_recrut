import os

class SQLProvider:
    def __init__(self, folder_path):
       
        if not os.path.exists(folder_path):
            raise ValueError(f"Указанная папка не существует: {folder_path}")
        self.folder_path = folder_path
    
    def get(self, file_name, **kwargs):
    
        file_path = os.path.join(self.folder_path, file_name)
        if not os.path.exists(file_path):
            raise FileNotFoundError(f"Файл SQL-запроса не найден: {file_name}")
        
        with open(file_path, 'r', encoding='utf-8') as file:
            sql = file.read()
        
        if kwargs:
            try:
                sql = sql.format(**kwargs)
            except KeyError as e:
                raise ValueError(f"Ошибка подстановки параметра: {e}")
        
        return sql
