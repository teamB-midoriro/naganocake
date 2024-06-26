# Nagano_cake
![IMG_0746](https://github.com/teamB-midoriro/naganocake/assets/158440003/f70ebcab-111a-4109-8b36-c54760b110a6)
# 概要
長野県にある小さな洋菓子店「ながのCAKE」の商品を通販するためのECサイト開発。

# 案件の背景
元々近隣住民が顧客だったが、昨年始めたInstagramから人気となり、全国から注文が来るようになった。
InstagramのDMやメールで通販の注文を受けていたが、情報管理が煩雑になってきたため、管理機能を含んだ通販サイトを開設しようと思い至った。

# 通販について
* 通販では注文に応じて製作する受注生産型としている。
* 現在通販での注文量は十分に対応可能な量のため、1日の受注量に制限は設けない。
* 送料は1配送につき全国一律800円。
* 友人や家族へのプレゼントなど、注文者の住所以外にも商品を発送できる。
* 支払方法はクレジットカード、銀行振込から選択できる。

# 実装機能
![機能一覧](https://github.com/teamB-midoriro/naganocake/assets/158440003/59ca8221-d4c9-4341-9b35-a4dc42e59add)

# ログイン方法
````
$ git clone git@github.com:teamB-midoriro/naganocake.git
$ cd naganocake
$ rails db:migrate
$ rails db:seed
$ yarn install
$ bundle install
$ rails s
````
管理者ログイン
* URLを/admin/sign_upにしてください。
* メールアドレス：admin@gmail.com
* パスワード：adminb

# Gem
````
gem 'devise'
gem 'kaminari','~> 1.2.1'
gem "enum_help"
gem 'bootstrap5-kaminari-views', '~> 0.0.1'
````
