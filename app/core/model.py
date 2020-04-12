import redis
import time
from config.db_config import REDIS_HOST, REDIS_PORT, REDIS_DB
from utils.utils import decode_dict

class Model:
    def __init__(self, id_digits=4):
        self._key = self.__class__.__name__.lower()
        self._counter_key = '{}_counter'.format(self._key)
        try:
            self._connection = redis.Redis(host=REDIS_HOST, port=REDIS_PORT, db=REDIS_DB)
            self.id_digits = id_digits
            self._init_count()
        except Exception as e:
            print(e)

    def _init_count(self):
        if not self._connection.exists(self._counter_key):
            self._add(self._counter_key, str(0).zfill(self.id_digits))            
        
        # delete this later
        # ** else:            
        #     ** self._add(self._counter_key, str(int(self.count())).zfill(self.id_digits))
    
    def _update_counter(self):
        # delete this later
        # ** current_count = self._get(self._counter_key)
        # ** next_count = str(int(current_count) + factor).zfill(self.id_digits)
        next_count = str(self.count() + 1).zfill(self.id_digits)
        self._add(self._counter_key, next_count)

    # Dalam program ini saya memutuskan semua data disimpan dalam
    # bentuk dictionary, jadi method add dan get single value saya tidak pakai

    def _add(self, key, value=''):
        self._connection.set(key, value)

    def _get(self, key):        
        return self._connection.get(key).decode('utf-8')

    def get_hash(self, key):
        return self._connection.hgetall(key)
    
    def is_exist(self, key):
        return self._connection.exists(key)

    def count(self):        
        return int(self._get('{}_counter'.format(self._key)))
    
    def insert(self, data):         
        _id = '{}_{}'.format(self._key, str(self.count()).zfill(self.id_digits))        
        
        if not self._connection.exists(_id):            
            data['_id'] = _id
            self._connection.hmset(_id, data)
            self._update_counter()

    def delete(self, query):
        models = self.where(query)        
        for model in models:            
            if '_id' in model:
                self._connection.delete(model['_id'])
    
    def update(self, data, primary_key='_id'):                
        if primary_key in data:
            temp = decode_dict(self.get_hash(data[primary_key]))                        
            for key in data.keys():
                temp[key] = data[key]
            self._connection.hmset(data[primary_key], temp)

    def where(self, query={}, logical='or', strict=False):        
        result = []                     
        for i in range(self.count()):            
            data = decode_dict(self.get_hash('{}_{}'.format(self._key, str(i).zfill(self.id_digits))))                                            
            
            if data == {}:
                continue    

            if query == {}:                
                result.append(data)             
            else:                     
                factor = len(query)               
                for key in query.keys():
                    if key in data:           
                        if callable(query[key]):                            
                            if query[key](data[key]):
                                # result.append(data)                                                                         
                                factor -= 1
                        else:
                            if strict:
                                if query[key].lower() == str(data[key]).lower():
                                    factor -= 1                            
                            else: 
                                if query[key].lower() in str(data[key]).lower():
                                    # result.append(data)
                                    factor -= 1             
                # print('{} factor'.format(factor))   
                if factor < len(query):                                        
                    if logical == 'and':
                        if factor == 0:                            
                            result.append(data)
                    else:
                        result.append(data)
        return result

    
            
            
