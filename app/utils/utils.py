def decode_dict(dict, charset='utf-8'):
    temp = {}
    for k, v in dict.items():
        if not isinstance(k, int):
            _k = k.decode(charset)
            temp[_k] = v.decode(charset)
    return temp