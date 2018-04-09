### Запуск
```
  git clone git@github.com:xfynx/exchange_rates_web_app.git
  cd exchange_rates_web_app
  bundle
  bundle exec rake db:create db:migrate db:seed
  whenever --update-crontab
  gem install foreman
  foreman start
```
Приложение запустится на *localhost:3001*, плюс в crontab добавится таск обновления заданных валют в базе (в сидах сейчас указаны Евро и Доллары) раз в час.
Для добавления новых валют для отслеживания, необходимо запустить консоль и добавить:
```
    ExchangeRate.set_rate('USD', 60, 'R01235')
```
где первый параметр - название валюты, второй - обменный курс к рублю, третий - id в ответе CBR.ru (пример ответа можно увидеть в *spec/fixtures/cbr_response.xml*)

Для изменения курса валют вручную, переходим на */admin* и логинимся (**email: 'admin@example.com', password: 'some-pass-word'**)
После этого в форме можно задавать курс и время, до которого курс этой валюты не будет меняться штатно.

При любом изменении курса валюты, у всех открытых страниц */* с отображением курсов автоматически через websocket'ы обновятся значения.