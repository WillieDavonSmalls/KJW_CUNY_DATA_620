import pandas as pd
from fuzzywuzzy import process
#%cd '/Users/williesmalls/Documents/School/CUNY\ SPS/01\ -\ Courses/00\ -\ Web\ Analytics/Data\ Play/project\ 1'

# import os
# os.chdir(path)

df_hero_network = pd.read_csv('hero-network.csv')
df_marvel_characters = pd.read_csv('marvel-wikia-data.csv')

lst_heroes = sorted(list(set(df_hero_network['hero1'].tolist() + df_hero_network['hero2'].tolist())))
lst_marvel_chars = list(df_marvel_characters['name'])

split = [
    [0, 500],
    [501, 1000],
    [1001, 1500],
    [1501, 2000],
    [2001, 2500],
    [2501, 3000],
    [3000, 3500],
    [3501, 4000],
    [4001, 4500],
    [4501, 5000],
    [5001, 5500],
    [5500, 6000],
    [6000, 6426],
    ]

# split = [[0, 10], [11, 20], [21, 30]]

for i in split:
    a = i[0]
    b = i[1]
    print('Begin: ' + str(a) + ' and ' + str(b))
    list_heroes_names = []
    for j in lst_heroes[a:b]:
        heroe_lookup = []
        heroe_lookup = [j, process.extractOne(j, lst_marvel_chars)]
        list_heroes_names.append(heroe_lookup)
    df_list_heroes_names = pd.DataFrame(list_heroes_names, columns=["heroe", "name"])
    df_list_heroes_names.to_csv('marvel_heroe_list.csv', mode='a', header=False, index=True)
    print('End: ' + str(a) + ' and ' + str(b))