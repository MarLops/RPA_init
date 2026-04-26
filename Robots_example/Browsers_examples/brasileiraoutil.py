from bs4 import BeautifulSoup


def get_positions(html) -> list:
    soup = BeautifulSoup(html,'html.parser')
    table_1 = soup.find('table',class_='tabela__equipes tabela__equipes--com-borda')
    rows = table_1.find('tbody').find_all('tr')

    data = []
    for row in rows:
        cols = [
            col.find('strong').get_text(strip=True)
            if col.find('strong')
            else col.get_text(strip=True)
            for col in row.find_all(['td', 'th'])
        ]
        data.append({
            "posicao":cols[0],
            "nome":cols[1]
        })

    table_2 = soup.find('table',class_='tabela__pontos')
    rows_pontos = table_2.find('tbody').find_all('tr')

    for index,row in zip(range(len(data)),rows_pontos):
        cols = [
            col.find('strong').get_text(strip=True)
            if col.find('strong')
            else col.get_text(strip=True)
            for col in row.find_all(['td', 'th'])
        ]
        data[index]['pontos'] = cols[0]
        data[index]['jogos'] = cols[1]
        data[index]['vitoria'] = cols[2]

    return data
