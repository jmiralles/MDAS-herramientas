import requests
import json
import unittest

def test():
    http_client('POST', {"topics":["bash","python","go"]})
    options = ["bash", "bash", "bash", "python"]
    expected_winner = "bash"

    for option in options:
        t = {"topic": option}
        http_client('PUT', t)

    winner_response = http_client('DEL')
    winner = winner_response["winner"]
    if winner == expected_winner:
        print("Test Passed!")
    else:
        print("Test Failed")    

def http_client(method, data={}):
    headers = {'Content-Type': 'application/json'}
    url = 'http://localhost:8080/vote'
     
    if method == 'POST':
        r = requests.post(url, json=data)
    elif method == 'PUT':
        r = requests.put(url, json=data)
    else:
        r = requests.delete(url, headers=headers)       

    print(r.json())  
    print(r.status_code)

    return r.json()  

test()
