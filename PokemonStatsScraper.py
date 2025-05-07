import requests
from bs4 import BeautifulSoup
import pandas as pd
import re
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
import time
from selenium.webdriver.common.action_chains import ActionChains


def scrape_pokemon_typing():
    url = "https://bulbapedia.bulbagarden.net/wiki/Type"
    response = requests.get(url)
    
    if response.status_code != 200:
        print("Failed to retrieve the page")
        return None

    soup = BeautifulSoup(response.text, 'html.parser')
    table = soup.find("table", {"class": "roundy"})

    pokemon_typing = []
    rows = table.find_all('tr')
    for row in rows[2:-1]: #skip first 2 rows and last row because they are headers
        element = row.find_all('th')[-1].text.strip() #the name of the element is always after a vertical header
        data = {
            'Type' : element,
            'Strong_against' : 0,
            'Weak_against' : 0,
            'Immune' : 0
        }
        for i in row: #counts each strengths/weaknesses
            number = i.text.strip()
            if number == '½×':
                data['Weak_against'] += 1
            elif number == '2×':
                data['Strong_against'] += 1
            elif number == '0×':
                data['Immune'] += 1
        pokemon_typing.append(data)
    df = pd.DataFrame(pokemon_typing)
    return df.to_csv(r'C:\Users\jackl\OneDrive\Desktop\Project 4\Pokemon_Typing.csv', index=False)

def scrape_pokemon_list(gen):   #the page is dynamically loaded as the user scrolls down
    driver = webdriver.Chrome()
    driver.get(f'https://www.smogon.com/dex/{gen}/pokemon/')
    pokemons = []
    prev_data = None
    body = ActionChains(driver)
    table = driver.find_element(By.CLASS_NAME, 'DexTable')

    while True:
        rows = table.find_elements(By.CLASS_NAME, 'PokemonAltRow  ')
        for row in rows:
            data = {
                'Gen': gen.upper(),
                'Pokemon': row.find_element(By.CLASS_NAME, 'PokemonAltRow-name').text,
                'Type_1': '',
                'Type_2': None,
                'Ability_1': None, 
                'Ability_2': None, 
                'Ability_3': None, 
                'HP': row.find_element(By.CSS_SELECTOR, 'div.PokemonAltRow-hp span').text,
                'ATK': row.find_element(By.CSS_SELECTOR, 'div.PokemonAltRow-atk span').text,
                'DEF': row.find_element(By.CSS_SELECTOR, 'div.PokemonAltRow-def span').text,
                'SPA': row.find_element(By.CSS_SELECTOR, 'div.PokemonAltRow-spa span').text,
                'SPD': row.find_element(By.CSS_SELECTOR, 'div.PokemonAltRow-spd span').text,
                'SPE': row.find_element(By.CSS_SELECTOR, 'div.PokemonAltRow-spe span').text
            }

            Types = row.find_elements(By.CLASS_NAME, 'PokemonAltRow-types')[0].text.split('\n') #There's always only 1 result: even 2 elements are connected by \n ie. Fire\nWater
            data['Type_1'] = Types[0]
            if len(Types) > 1:
                data['Type_2'] = Types[1]
            Abilities = row.find_elements(By.CLASS_NAME, 'PokemonAltRow-abilities')
            count = 1
            for i in range(len(Abilities)): #Finding Abilities
                abil = Abilities[i].text
                x = re.compile(r'\n')
                search = x.search(abil)
                if search: #if there is 2 abilities in 1 column
                    doubleAbilities = abil.split('\n')
                    data[f'Ability_{count}'] = doubleAbilities[0]
                    count += 1
                    data[f'Ability_{count}'] = doubleAbilities[1]
                elif abil:
                    data[f'Ability_{count}'] = abil
                count +=1
            pokemons.append(data)
        if data == prev_data: #if the prev page is the same as the current page
            break
        prev_data = data
        body.send_keys(Keys.PAGE_DOWN).perform()
        time.sleep(3)

        print(pokemons[-1])
    
    df = pd.DataFrame(pokemons)
    return df.to_csv(r'C:\Users\jackl\OneDrive\Desktop\Project 4\Gen_RB.csv', index=False)


def scrape_tier_list():
    driver = webdriver.Chrome() 
    final = pd.DataFrame()
    gens = ('rb', 'gs', 'rs', 'dp', 'bw', 'xy', 'sm', 'ss', 'sv')
    tiers = ('uber', 'ou', 'uu', 'ru', 'nu')
    errors = {}
    for gen in gens:
        for tier in tiers:
            try:  #in case the page doesn't exist
                driver.get(f'https://www.smogon.com/dex/{gen}/formats/{tier}/')

                table = driver.find_element(By.CSS_SELECTOR, 'section[data-reactid=".0.1.1.7"]')
                rows = table.find_elements(By.CLASS_NAME, 'PokemonAltRow  ')
                pokemons = []
                for row in rows:
                    data = {
                        'Gen': gen.upper(),
                        'Pokemon': row.find_element(By.CLASS_NAME, 'PokemonAltRow-name').text,
                        'Type_1': '',
                        'Type_2': None,
                        'Ability_1': None, 
                        'Ability_2': None, 
                        'Ability_3': None, 
                        'Tier': row.find_element(By.CLASS_NAME, 'PokemonAltRow-tags').text,
                        'HP': row.find_element(By.CSS_SELECTOR, 'div.PokemonAltRow-hp span').text,
                        'ATK': row.find_element(By.CSS_SELECTOR, 'div.PokemonAltRow-atk span').text,
                        'DEF': row.find_element(By.CSS_SELECTOR, 'div.PokemonAltRow-def span').text,
                        'SPA': row.find_element(By.CSS_SELECTOR, 'div.PokemonAltRow-spa span').text,
                        'SPD': row.find_element(By.CSS_SELECTOR, 'div.PokemonAltRow-spd span').text,
                        'SPE': row.find_element(By.CSS_SELECTOR, 'div.PokemonAltRow-spe span').text
                    }

                    Types = row.find_elements(By.CLASS_NAME, 'PokemonAltRow-types')[0].text.split('\n') #There's always only 1 result: even 2 elements are connected by \n ie. Fire\nWater
                    data['Type_1'] = Types[0]
                    if len(Types) > 1:
                        data['Type_2'] = Types[1]

                    Abilities = row.find_elements(By.CLASS_NAME, 'PokemonAltRow-abilities')
                    count = 1
                    for i in range(len(Abilities)): #Finding Abilities
                        abil = Abilities[i].text
                        x = re.compile(r'\n')
                        search = x.search(abil)
                        if search: #if there is 2 abilities in 1 column
                            doubleAbilities = abil.split('\n')
                            data[f'Ability_{count}'] = doubleAbilities[0]
                            count += 1
                            data[f'Ability_{count}'] = doubleAbilities[1]
                        elif abil:
                            data[f'Ability_{count}'] = abil
                        count += 1

                    pokemons.append(data)
                df = pd.DataFrame(pokemons)
                final = pd.concat([final, df], ignore_index=True)
                print(gen, tier, final.tail(1))
            except:
                print(f'Encountered blank page in gen: {gen}, tier: {tier}')
                errors[gen] = tier
                continue
    print(errors)
    return final.to_csv(r'C:\Users\jackl\OneDrive\Desktop\Project 4\testy.csv', index=False)

def column_name_changer(Gen):
    df = pd.read_csv(f"C:\\Users\\jackl\\OneDrive\\Desktop\\Project 4\\Gen_{Gen}.csv")
    column_names = list(df.columns)
    for i in range(len(column_names)):
        newname = re.sub(r'[.]', '_', column_names[i])
        column_names[i] = newname
    df.columns = column_names
    return df.to_csv(f"C:\\Users\\jackl\\OneDrive\\Desktop\\Project 4\\Gen_{Gen}.csv", index=False)

column_name_changer("XY")