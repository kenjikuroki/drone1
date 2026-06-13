# JSON反映手順

この手順は、既存公開問題を保護したまま、新規問題だけを `assets/quiz_data.json` に反映するための運用ルールである。

## 対象

- 対象ファイル: [assets/quiz_data.json](/Users/kurok/StudioProjects/02.sikaku/drone1/assets/quiz_data.json)
- 管理台帳:
  - [docs/part1_question_bank_template.csv](/Users/kurok/StudioProjects/02.sikaku/drone1/docs/part1_question_bank_template.csv)
  - [docs/part2_question_bank_template.csv](/Users/kurok/StudioProjects/02.sikaku/drone1/docs/part2_question_bank_template.csv)

## 固定ルール

- `part1` の既存公開問題は `P1-001` から `P1-026` までとする。
- `part2` の既存公開問題は `P2-001` から `P2-035` までとする。
- 既存公開問題は、法令誤りの是正を除き、問題文・正誤・解説の意味を変更しない。
- 公開後に調整するのは新規問題のみとする。

## 反映前チェック

1. 台帳の対象カテゴリが `approved` でそろっていることを確認する。
2. `app_ready` が対象問題ですべて `yes` になっていることを確認する。
3. 既存公開問題の行に変更差分が入っていないことを確認する。
4. 正誤比を確認する。
5. 中分類配分が計画どおりか確認する。
6. 同一論点の近接重複が強すぎないか確認する。

## 反映単位

- `part1` は既存26問を先頭固定とし、その後ろに新規74問を追加する。
- `part2` は既存35問を先頭固定とし、その後ろに新規65問を追加する。
- 既存問題の並び順は変えない。
- 新規問題は台帳ID順で末尾追加する。

## 反映ルール

1. CSV台帳から `question`、`is_correct`、`explanation` だけをJSON用に抜き出す。
2. JSONの `question` には台帳の `statement` を入れる。
3. JSONの `isCorrect` には台帳の `is_correct` を入れる。
4. JSONの `explanation` には台帳の `explanation` を入れる。
5. JSON側には台帳の `id`、`subcategory`、`source` は入れない。
6. 既存公開問題部分は上書きではなく、差分比較のうえ据え置く。

## 反映手順

1. `assets/quiz_data.json` をバックアップする。
2. `part1` の既存26問が現行公開版と一致していることを確認する。
3. `part1` の27問目以降を台帳 `P1-027` から `P1-100` で置き換える。
4. `part2` の既存35問が現行公開版と一致していることを確認する。
5. `part2` の36問目以降を台帳 `P2-036` から `P2-100` で置き換える。
6. JSON全体の構文検証を行う。
7. 各カテゴリの件数を再集計する。
8. 各カテゴリの正誤比を再集計する。

## 反映後チェック

- `part1` が100問であること
- `part2` が100問であること
- `part1` の正誤比が `正60 / 誤40` であること
- `part2` の正誤比が `正60 / 誤40` であること
- 既存公開問題の先頭領域に差分がないこと
- アプリ起動時にJSON読み込みエラーが出ないこと

## 障害時の戻し方

1. JSON構文エラーが出た場合は、バックアップから即時復元する。
2. 既存公開問題に差分が混入していた場合は、その反映を破棄する。
3. 新規問題に不具合が見つかった場合は、既存公開問題を残したまま新規部分のみ差し戻す。

## 運用メモ

- 既存公開問題の保護が最優先である。
- 比率調整や文面調整は、公開前の新規問題側で完結させる。
- 将来 `part3`、`part4` を100問化する場合も同じ方式を使う。
