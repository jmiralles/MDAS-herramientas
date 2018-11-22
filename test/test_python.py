import requests

def test():    
    expected_winner = "bash"

    create_initial_elements()
    vote_each_element()
   
    winner_response = get_winner_element()
    winner = winner_response["winner"]

    if winner == expected_winner:
        print("Test Passed!")
        return 0
    else:
        print("Test Failed")
        return 1   

def get_winner_element():
    return http_client('DELETE')

def create_initial_elements():
    http_client('POST', {"topics":["bash","python","go"]})

def vote_each_element():
    options = ["bash", "bash", "bash", "python"]

    for option in options:
            t = {"topic": option}
            http_client('PUT', t)

def http_client(method, data={}):
    print(data)

    headers = {'Content-Type': 'application/json'}
    url = 'http://votingapp:80/vote'
     
    if method == 'POST':
        r = requests.post(url, json=data)
    elif method == 'PUT':
        r = requests.put(url, json=data)
    elif method == 'DELETE':
        r = requests.delete(url, headers=headers)       
    else:
        raise ValueError('Method not available!')

    return r.json()  


test()
