# ddt-ironman

## What is DDT Ironman Heavymetalweight Championship?

https://ja.wikipedia.org/wiki/アイアンマンヘビーメタル級王座

## Database of Ironman Heavymetalweight Championship

https://github.com/ytkhs/ddt-ironman/blob/master/data/winners.json

### example (ranking)

```
# with `jq` command
$ curl -s https://raw.githubusercontent.com/ytkhs/ddt-ironman/master/data/winners.json | jq  'map({name: .name}) | group_by(.name) | map({name: .[0].name, count:length}) | sort_by(.count) | map((.count | tostring) + " : " + (.name | tostring))'
```

## usage

To update the `data/winners.json` file, run the following command:

```
python update_winners.py > data/winners.json
```
