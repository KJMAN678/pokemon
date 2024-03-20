# %%
import asyncio
import nest_asyncio

from poke_env.player.random_player import RandomPlayer
from poke_env.player.utils import cross_evaluate
from tabulate import tabulate

nest_asyncio.apply()


# %%
async def main():
    # ランダム行動をするPlayerオブジェクトを3個作成します
    players = [RandomPlayer(max_concurrent_battles=10) for _ in range(3)]

    # 相互に対戦させ評価を行います。Player同士の一つの組合わせごとに、20回の対戦を行います。
    cross_evaluation = await cross_evaluate(players, n_challenges=20)

    # 表示用のヘッダー行を作成します
    table = [["-"] + [p.username for p in players]]

    # 対戦結果を抽出して、それぞれのPlayerごとに1行ずつtableオブジェクトに追加していきます
    for p_1, results in cross_evaluation.items():
        table.append([p_1] + [cross_evaluation[p_1][p_2] for p_2 in results])

    # 見やすい表形式で結果を表示します
    print(tabulate(table))


# %%
if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
