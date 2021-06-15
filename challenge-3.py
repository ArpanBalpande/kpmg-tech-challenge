#!/usr/bin/env python
import json

def convert(object, key):
    dict_object = json.loads(object)
    keys = key.split('/')
    for i in range(len(keys)):
        if keys[i] in dict_object.keys():
            dict_object = dict_object[keys[i]]
        else:
            return "Key not found."
    return dict_object

print(convert('{"x":{"y":{"z":"a"}}, "p":{"q": {"r": "b"}}}', "p/q"))
