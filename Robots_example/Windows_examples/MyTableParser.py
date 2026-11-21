from robot.api.deco import keyword


class MyTableParser:

    @keyword("Extract Games From Table")
    def extract_games_from_table(self, table):

        games = []
        print(table)
        print(type(table))
        print(dir(table))
        # get rows
        '''
        rows = table.find_elements("type:DataItem")

        for row in rows:

            columns = row.find_elements("type:DataItem")

            if len(columns) >= 2:
                rank = columns[0].name
                game = columns[1].name

                games.append({
                    "rank": rank,
                    "game": game
                })
        '''
        return games

    @keyword("Parse Table Tree")
    def parse_table_tree(self, tree):

        result = []

        print(tree)

        games = {}

        elements = tree.get(2, [])

        for element in elements:

            locator = element.locator
            name = element.name

            path = locator.split("path:")[-1]
            parts = path.split("|")

            if len(parts) < 2:
                continue

            row = int(parts[0])

            if row not in games:
                games[row] = {}

            # DataItemControl
            if len(parts) == 2:

                column = int(parts[1])

                if column == 1:
                    games[row]["rank"] = name

                elif column == 2:
                    games[row]["game"] = name

                elif column == 3:
                    games[row]["discount"] = name

                elif column == 4:
                    games[row]["change"] = name

                elif column == 5:
                    games[row]["weeks"] = name


            # HyperlinkControl
            elif len(parts) == 3:

                parent_column = int(parts[1])

                if parent_column == 2:
                    games[row]["link_text"] = name
                    games[row]["locator"] = locator


        return list(games.values())