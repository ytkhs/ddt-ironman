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

## How to install
1. git clone git@github.com:ytkhs/ddt-ironman.git
2. cd ddt-ironman
3. bundle install

## usage

```
bundle exec rake ih:latest
# => #1300  2018-04-22 スーパーササダンゴマシン


bundle exec rake ih:all
# => #1     2000-06-29 ポイズン澤田BLACK
     #2     2000-06-29 菊澤光信		
		 .
		 .
		 .
     #1300  2018-04-22 スーパーササダンゴマシン	
```