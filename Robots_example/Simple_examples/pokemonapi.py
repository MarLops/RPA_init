import requests

def get_pokemon(id:str):
    """
    Get pokemon
    """
    url = f'https://pokeapi.co/api/v2/pokemon/{id}'
    response = requests.get(url)
    if response.status_code == 200:
        return response.json()
    return dict()