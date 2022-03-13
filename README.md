## 第3章 ほぼ静的なページの作成

### 変更点
- Gemfileに下記を追加
  - https://teratail.com/questions/343233

### インストール手順
  - このリポジトリをクローンしてください。
  - 下記の手順を参考にrailsをビルドしてください。
    - [- https://qiita.com/kodai_0122/items/795438d738386c2c1966](https://qiita.com/kodai_0122/items/795438d738386c2c1966)
      1. `docker-compose run web rails new . --force --no-deps --database=postgresql --skip-bundle`
      2. `docker-compose build`
      3. `config/database.yml`を編集
      4. `docker-compose run web rails webpacker:install`
      5. `docker-compose run web rails webpacker:compile`
      7. `docker-compose run web rake db:crate`
      8. `docker-compose run web rake db:migrate`
      9. `docker-compose up`
      10. `http://localhost:3000`にアクセス
 ### herokuへのデプロイ
 1. `heroku login --interactive`
 2. 